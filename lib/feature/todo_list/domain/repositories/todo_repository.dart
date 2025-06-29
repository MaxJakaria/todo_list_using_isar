import 'package:dartz/dartz.dart';
import 'package:todo_list_using_isar/core/error/failure.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/entities/todo.dart';

abstract interface class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();
  Stream<Either<Failure, List<Todo>>> watchTodos();
  Future<Either<Failure, Todo>> addTodo({
    required String title,
    required String details,
    required bool isComplete,
    required DateTime updatedAt,
  });
  Future<Either<Failure, Todo>> updateTodo({
    required String id,
    String? title,
    String? details,
    bool? isComplete,
    DateTime? updatedAt,
  });
  Future<Either<Failure, void>> deleteTodo({required String id});
}
