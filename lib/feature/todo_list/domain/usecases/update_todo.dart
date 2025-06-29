import 'package:dartz/dartz.dart';
import 'package:todo_list_using_isar/core/error/failure.dart';
import 'package:todo_list_using_isar/core/usecase/usecase.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/entities/todo.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/repositories/todo_repository.dart';

class UpdateTodo implements Usecase<Todo, UpdateTodoParams> {
  final TodoRepository repository;

  UpdateTodo({required this.repository});

  @override
  Future<Either<Failure, Todo>> call(UpdateTodoParams params) async {
    return await repository.updateTodo(
      id: params.id,
      title: params.title,
      details: params.details,
      isComplete: params.isComplete,
      updatedAt: params.updatedAt,
    );
  }
}

class UpdateTodoParams {
  final String id;
  String? title;
  String? details;
  bool? isComplete;
  DateTime? updatedAt;

  UpdateTodoParams({
    required this.id,
    this.title,
    this.details,
    this.isComplete,
    this.updatedAt,
  });
}
