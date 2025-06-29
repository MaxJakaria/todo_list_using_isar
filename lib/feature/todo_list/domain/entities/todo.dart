class Todo {
  final String id;
  final String title;
  final String details;
  final bool isComplete;
  final DateTime updatedAt;

  Todo({
    required this.id,
    required this.title,
    required this.details,
    required this.isComplete,
    required this.updatedAt,
  });
}
