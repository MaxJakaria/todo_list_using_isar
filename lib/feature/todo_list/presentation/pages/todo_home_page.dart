import 'package:flutter/material.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/utils/show_todo_add_dialog.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/utils/show_todo_delete_dialog.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/utils/show_todo_edit_dialog.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/widgets/todo_list_view.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),

      body: TodoListView(
        todos: [],
        onEdit: (todo) => showTodoEditDialog(
          context: context,
          id: todo.id,
          initialTitle: todo.title,
          initialDetails: todo.details,
        ),
        onDelete: (id) => showTodoDeleteDialog(context: context, id: id),
        onToggleComplete: (id, val) {},
        onTap: (todo) {},
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showTodoAddDialog(context: context),
        label: const Text('Add Todo'),
        icon: const Icon(Icons.add),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
