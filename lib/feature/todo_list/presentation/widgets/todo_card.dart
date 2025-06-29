import 'package:flutter/material.dart';
import 'package:todo_list_using_isar/core/app_pallete/app_pallete.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final bool isComplete;
  final Function(bool?) onCheckboxChanged;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;
  final VoidCallback onTap;

  const TodoCard({
    super.key,
    required this.title,
    required this.isComplete,
    required this.onCheckboxChanged,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          children: [
            Checkbox(value: isComplete, onChanged: onCheckboxChanged),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  decoration: isComplete ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            IconButton(
              onPressed: onEditPressed,
              icon: Icon(Icons.edit, color: edit),
            ),
            IconButton(
              onPressed: onDeletePressed,
              icon: Icon(Icons.delete, color: delete),
            ),
          ],
        ),
      ),
    );
  }
}
