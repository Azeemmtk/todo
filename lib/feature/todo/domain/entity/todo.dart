class Todo {
  final String? id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isComplete;

  Todo({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isComplete,
  });
}