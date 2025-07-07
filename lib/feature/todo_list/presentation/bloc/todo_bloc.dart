import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_using_isar/core/error/failure.dart';
import 'package:todo_list_using_isar/core/usecase/usecase.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/entities/todo.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/usecases/add_todo.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/usecases/delete_todo.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/usecases/get_todos.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/usecases/update_todo.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/usecases/watch_todos.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final AddTodo addTodo;
  final DeleteTodo deleteTodo;
  final UpdateTodo updateTodo;
  final GetTodos getTodos;
  final WatchTodos watchTodos;

  TodoBloc({
    required this.addTodo,
    required this.deleteTodo,
    required this.updateTodo,
    required this.getTodos,
    required this.watchTodos,
  }) : super(TodoInitial()) {
    on<LoadTodosEvent>(_onLoadTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<StartWatchTodosEvent>(_onStartWatchTodos);
    on<LoadTodosByDateEvent>(_onLoadTodosByDate);
  }

  Future<void> _onLoadTodos(
    LoadTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    final result = await getTodos(NoParams());
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (todos) => emit(TodoLoaded(todos)),
    );
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    final result = await addTodo(
      AddTodoParams(
        title: event.title,
        details: event.details,
        isComplete: event.isComplete,
        updatedAt: event.updatedAt,
        scheduledTime: event.scheduledTime,
      ),
    );
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (_) => add(const StartWatchTodosEvent()), // Refresh todos after add
    );
  }

  Future<void> _onUpdateTodo(
    UpdateTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final result = await updateTodo(
      UpdateTodoParams(
        id: event.id,
        title: event.title,
        details: event.details,
        isComplete: event.isComplete,
        updatedAt: event.updatedAt,
        scheduledTime: event.scheduledTime, // Pass scheduledTime
      ),
    );
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (_) => add(const StartWatchTodosEvent()), // Refresh todos after update
    );
  }

  Future<void> _onDeleteTodo(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final result = await deleteTodo(DeleteTodoParams(id: event.id));
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (_) => add(const StartWatchTodosEvent()), // Refresh todos after delete
    );
  }

  Future<void> _onStartWatchTodos(
    StartWatchTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading()); // Emit loading state before starting to watch

    await emit.forEach<Either<Failure, List<Todo>>>(
      watchTodos(NoParams()), // Still watch all todos from repo
      onData: (result) => result.fold((failure) => TodoError(failure.message), (
        todos,
      ) {
        // Filter todos based on selectedDate here in the BLoC for convenience
        // If event.selectedDate is null, show all. Otherwise, filter by date.
        if (event.selectedDate != null) {
          final filteredTodos = todos.where((todo) {
            return todo.scheduledTime.year == event.selectedDate!.year &&
                todo.scheduledTime.month == event.selectedDate!.month &&
                todo.scheduledTime.day == event.selectedDate!.day;
          }).toList();
          return TodoLoaded(filteredTodos);
        }
        return TodoLoaded(todos); // No filter applied
      }),
      onError: (error, stackTrace) => TodoError(error.toString()),
    );
  }

  // New event handler for loading todos by a specific date
  Future<void> _onLoadTodosByDate(
    LoadTodosByDateEvent event,
    Emitter<TodoState> emit,
  ) async {
    // Here, we emit a loading state and then start watching filtered todos
    emit(TodoLoading());
    // Re-use StartWatchTodosEvent but with the specific date
    add(StartWatchTodosEvent(selectedDate: event.date));
  }
}
