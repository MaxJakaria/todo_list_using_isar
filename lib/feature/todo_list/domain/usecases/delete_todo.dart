import 'package:dartz/dartz.dart';
import 'package:todo_list_using_isar/core/error/failure.dart';
import 'package:todo_list_using_isar/core/usecase/usecase.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/repositories/todo_repository.dart';

class DeleteTodo implements Usecase<void, DeleteTodoParams> {
  final TodoRepository repository;

  DeleteTodo({required this.repository});

  @override
  Future<Either<Failure, void>> call(DeleteTodoParams params) async {
    return await repository.deleteTodo(id: params.id);
  }
}

class DeleteTodoParams {
  final String id;
  DeleteTodoParams({required this.id});
}
