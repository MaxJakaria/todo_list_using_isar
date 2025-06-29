import 'package:flutter/material.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/widgets/todo_dialog.dart';

Future<void> showTodoDeleteDialog({
  required BuildContext context,
  required String id,
}) async {
  await showDialog(
    context: context,
    builder: (_) => TodoDialog(
      message: 'Are you sure want to delete this item?',
      fields: const [],
      cancelButtonText: 'Cancel',
      actionButtonText: 'Delete',
      onAction: (_) {
        Navigator.pop(context);
      },
      onCancel: () => Navigator.pop(context),
    ),
  );
}
