class Todo {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  Todo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        id: json["id"],
        todo: json["todo"],
        completed: json["completed"],
        userId: json["userId"]);
  }
}
