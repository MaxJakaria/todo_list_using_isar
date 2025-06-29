import 'package:flutter/material.dart';
import 'package:todo_list_using_isar/core/common/dialog_button.dart';
import 'package:todo_list_using_isar/core/common/text_field_config.dart';

class TodoDialog extends StatefulWidget {
  final String? dialogTitle;
  final String? message;
  final List<TextFieldConfig> fields;
  final String cancelButtonText;
  final String actionButtonText;
  final VoidCallback? onCancel;
  final Function(Map<String, String> result)? onAction;

  const TodoDialog({
    super.key,
    this.dialogTitle,
    this.message,
    this.fields = const [],
    this.cancelButtonText = 'Cancel',
    required this.actionButtonText,
    this.onCancel,
    this.onAction,
  });

  @override
  State<TodoDialog> createState() => _DynamicDialogState();
}

class _DynamicDialogState extends State<TodoDialog> {
  final Map<String, TextEditingController> _controllers = {};
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    for (var config in widget.fields) {
      _controllers[config.id] = TextEditingController(
        text: config.initialValue ?? '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.dialogTitle != null
          ? Center(child: Text(widget.dialogTitle!))
          : null,
      titlePadding: widget.dialogTitle != null
          ? const EdgeInsets.only(top: 15, bottom: 5)
          : const EdgeInsets.all(5),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.message != null) Text(widget.message!),
            ...widget.fields.map((config) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  controller: _controllers[config.id],
                  decoration: InputDecoration(labelText: config.labelText),
                  maxLines: config.maxLines,
                  minLines: config.minLines,
                  validator: (value) {
                    if (config.isBlankError != null &&
                        (value == null || value.trim().isEmpty)) {
                      return '${config.labelText} cann\'t be empty!';
                    }
                    return null;
                  },
                ),
              );
            }),
          ],
        ),
      ),
      actions: [
        DialogButton(
          text: widget.cancelButtonText,
          onPressed: () {
            if (widget.onCancel != null) {
              widget.onCancel!();
            } else {
              Navigator.pop(context);
            }
          },
          isPrimaryAction: false,
        ),
        DialogButton(
          text: widget.actionButtonText,
          onPressed: () {
            if (!(_formKey.currentState?.validate() ?? false)) return;

            final result = <String, String>{};
            _controllers.forEach((id, controller) {
              result[id] = controller.text;
            });

            if (widget.onAction != null) {
              widget.onAction!(result);
            } else {
              Navigator.pop(context, result);
            }
          },
          isPrimaryAction: true,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }
}
