import 'dart:convert';

class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  Todo copyWith({
    int userId,
    int id,
    String title,
    bool completed,
  }) {
    return Todo(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Todo(
      userId: map['userId']?.toInt(),
      id: map['id']?.toInt(),
      title: map['title'],
      completed: map['completed'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(jsonDecode(source));

  @override
  String toString() {
    return 'Todo(userId: $userId, id: $id, title: $title, completed: $completed)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Todo && o.userId == userId && o.id == id && o.title == title && o.completed == completed;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ id.hashCode ^ title.hashCode ^ completed.hashCode;
  }

  static List<Todo> fromMapList(dynamic jsonData) {
    if (jsonData == null || jsonData is! List) return null;
    return (jsonData as List).map((x) => Todo.fromMap(x)).toList();
  }

  static List<Todo> fromJsonList(String jsonString) => fromMapList(jsonDecode(jsonString));
}
