import 'package:dartz/dartz.dart';
import 'package:todo_list_using_isar/core/error/failure.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/entities/todo.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/repositories/todo_repository.dart';
import 'dart:async';

class TodoRepositoryImpl implements TodoRepository {
  final List<Todo> _todos = [];
  final StreamController<List<Todo>> _streamController =
      StreamController.broadcast();

  int _idCounter = 0;

  void _notify() {
    _streamController.add(List.unmodifiable(_todos));
  }

  @override
  Future<Either<Failure, Todo>> addTodo({
    required String title,
    required String details,
    required bool isComplete,
    required DateTime updatedAt,
  }) async {
    final todo = Todo(
      id: (++_idCounter).toString(),
      title: title,
      details: details,
      isComplete: isComplete,
      updatedAt: updatedAt,
    );
    _todos.add(todo);
    _notify();
    return Right(todo);
  }

  @override
  Future<Either<Failure, void>> deleteTodo({required String id}) async {
    _todos.removeWhere((todo) => todo.id == id);
    _notify();
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    return Right(List.unmodifiable(_todos));
  }

  @override
  Future<Either<Failure, Todo>> updateTodo({
    required String id,
    String? title,
    String? details,
    bool? isComplete,
    DateTime? updatedAt,
  }) async {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index == -1) {
      return Left(Failure('Todo not found'));
    }

    final old = _todos[index];
    final updated = Todo(
      id: old.id,
      title: title ?? old.title,
      details: details ?? old.details,
      isComplete: isComplete ?? old.isComplete,
      updatedAt: updatedAt ?? old.updatedAt,
    );

    _todos[index] = updated;
    _notify();
    return Right(updated);
  }

  @override
  Stream<Either<Failure, List<Todo>>> watchTodos() async* {
    yield Right(List.unmodifiable(_todos));
    yield* _streamController.stream.map((todos) => Right(todos));
  }
}
