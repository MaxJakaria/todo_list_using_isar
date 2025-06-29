import 'package:isar/isar.dart';
import 'package:todo_list_using_isar/feature/todo_list/data/datasources/todo_local_data_source.dart';
import 'package:todo_list_using_isar/feature/todo_list/data/models/todo_model.dart';

class TodoLocalDataSourceImpl implements TodoLocalDatasource {
  final Isar isar;

  TodoLocalDataSourceImpl({required this.isar});

  @override
  Future<TodoModel> addTodo(TodoModel todo) async {
    final todoModel = TodoModel.fromEntity(todo);
    await isar.writeTxn(() async {
      await isar.todoModels.put(todoModel);
    });

    return todoModel.toEntity();
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todo = await isar.todoModels.filter().idEqualTo(id).findFirst();

    if (todo != null) {
      await isar.writeTxn(() async {
        await isar.todoModels.delete(todo.isarId);
      });
    }
  }

  @override
  Future<List<TodoModel>> getTodos() async {
    final todos = await isar.todoModels.where().findAll();

    return todos.map((model) => model.toEntity()).toList();
  }

  @override
  Future<TodoModel> updateTodo(TodoModel todo) async {
    final todoModel = TodoModel.fromEntity(todo);
    await isar.writeTxn(() async {
      await isar.todoModels.put(todoModel);
    });

    return todoModel.toEntity();
  }

  @override
  Stream<List<TodoModel>> watchTodos() {
    return isar.todoModels
        .where()
        .watch(fireImmediately: true)
        .map((models) => models.map((model) => model.toEntity()).toList());
  }
}
