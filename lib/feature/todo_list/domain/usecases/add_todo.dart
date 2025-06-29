import 'package:dartz/dartz.dart';
import 'package:todo_list_using_isar/core/error/failure.dart';
import 'package:todo_list_using_isar/core/usecase/usecase.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/entities/todo.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/repositories/todo_repository.dart';

class AddTodo implements Usecase<Todo, AddTodoParams> {
  final TodoRepository repository;

  AddTodo({required this.repository});

  @override
  Future<Either<Failure, Todo>> call(AddTodoParams params) async {
    return await repository.addTodo(
      title: params.title,
      details: params.details,
      isComplete: params.isComplete,
      updatedAt: params.updatedAt,
    );
  }
}

class AddTodoParams {
  final String title;
  final String details;
  final bool isComplete;
  final DateTime updatedAt;

  AddTodoParams({
    required this.title,
    required this.details,
    required this.isComplete,
    required this.updatedAt,
  });
}
