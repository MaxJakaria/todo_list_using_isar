import 'dart:async';
import 'package:todo_list_using_isar/feature/todo_list/data/models/todo_model.dart';

abstract interface class TodoLocalDatasource {
  Future<List<TodoModel>> getTodos();
  Stream<List<TodoModel>> watchTodos();
  Future<TodoModel> addTodo(TodoModel todo);
  Future<TodoModel> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}
