// feature/todo_list/presentation/bloc/todo_event.dart
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
  final DateTime scheduledTime;

  const AddTodoEvent({
    required this.title,
    required this.details,
    required this.isComplete,
    required this.updatedAt,
    required this.scheduledTime,
  });
}

final class UpdateTodoEvent extends TodoEvent {
  final String id;
  final String? title;
  final String? details;
  final bool? isComplete;
  final DateTime? updatedAt;
  final DateTime? scheduledTime; // Add scheduledTime

  const UpdateTodoEvent({
    required this.id,
    this.title,
    this.details,
    this.isComplete,
    this.updatedAt,
    this.scheduledTime, // Add to constructor
  });
}

final class DeleteTodoEvent extends TodoEvent {
  final String id;

  const DeleteTodoEvent({required this.id});
}

final class StartWatchTodosEvent extends TodoEvent {
  final DateTime?
  selectedDate; // Optional: to watch todos for a specific date, or null for all
  const StartWatchTodosEvent({this.selectedDate});
}

// New event to explicitly load todos for a selected date (for calendar)
final class LoadTodosByDateEvent extends TodoEvent {
  final DateTime date;
  const LoadTodosByDateEvent({required this.date});
}
