import 'package:flutter/material.dart';
import 'package:todo_list_using_isar/feature/todo_list/domain/entities/todo.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/widgets/todo_card.dart';

class TodoListView extends StatelessWidget {
  final List<Todo> todos;
  final void Function(Todo) onEdit;
  final void Function(String) onDelete;
  final void Function(String id, bool? isChecked) onToggleComplete;
  final void Function(Todo) onTap;

  const TodoListView({
    super.key,
    required this.todos,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleComplete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoCard(
          key: ValueKey(todo.id),
          title: todo.title,
          isComplete: todo.isComplete,
          onCheckboxChanged: (val) => onToggleComplete(todo.id, val),
          onEditPressed: () => onEdit(todo),
          onDeletePressed: () => onDelete(todo.id),
          onTap: () => onTap(todo),
        );
      },
    );
  }
}
