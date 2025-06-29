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
      ),
    );
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (_) => add(const LoadTodosEvent()),
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
      ),
    );
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (_) => add(const LoadTodosEvent()),
    );
  }

  Future<void> _onDeleteTodo(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final result = await deleteTodo(DeleteTodoParams(id: event.id));
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (_) => add(const LoadTodosEvent()),
    );
  }

  Future<void> _onStartWatchTodos(
    StartWatchTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(const TodoLoaded([]));

    await emit.forEach<Either<Failure, List<Todo>>>(
      watchTodos(NoParams()),
      onData: (result) => result.fold(
        (failure) => TodoError(failure.message),
        (todos) => TodoLoaded(todos),
      ),
    );
  }
}
