import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_using_isar/feature/todo_list/presentation/bloc/todo_bloc.dart';
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
        context.read<TodoBloc>().add(DeleteTodoEvent(id: id));
        Navigator.pop(context);
      },
      onCancel: () => Navigator.pop(context),
    ),
  );
}
