import 'package:flutter/material.dart';
import 'package:todo_list_using_isar/core/common/text_field_config.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/widgets/todo_dialog.dart';

Future<void> showTodoAddDialog({required BuildContext context}) async {
  await showDialog<Map<String, String>>(
    context: context,
    builder: (_) => TodoDialog(
      dialogTitle: 'Add New Todo',
      fields: const [
        TextFieldConfig(
          id: 'todoTitle',
          labelText: 'Title',
          isBlankError: true,
        ),
        TextFieldConfig(id: 'todoDetails', labelText: 'Details', maxLines: 4),
      ],
      actionButtonText: 'Add',
      onAction: (data) {
        Navigator.pop(context);
      },
      onCancel: () => Navigator.pop(context),
    ),
  );
}
