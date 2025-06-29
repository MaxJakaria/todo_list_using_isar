part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {
  const TodoEvent();
}

final class LoadTodosEvent extends TodoEvent {
  const LoadTodosEvent();
}

final class AddTodoEvent extends TodoEvent {
  final String title;
  final String details;
  final bool isComplete;
  final DateTime updatedAt;

  const AddTodoEvent({
    required this.title,
    required this.details,
    required this.isComplete,
    required this.updatedAt,
  });
}

final class UpdateTodoEvent extends TodoEvent {
  final String id;
  final String? title;
  final String? details;
  final bool? isComplete;
  final DateTime? updatedAt;

  const UpdateTodoEvent({
    required this.id,
    this.title,
    this.details,
    this.isComplete,
    this.updatedAt,
  });
}

final class DeleteTodoEvent extends TodoEvent {
  final String id;

  const DeleteTodoEvent({required this.id});
}

final class StartWatchTodosEvent extends TodoEvent {
  const StartWatchTodosEvent();
}
