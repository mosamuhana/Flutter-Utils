import 'package:http/http.dart' as http;

import '../models.dart';

const _BASE_URL = 'https://jsonplaceholder.typicode.com/todos';

const _headers = <String, String>{
  'Content-Type': 'application/json',
};

class TodoService {
  static TodoService _instance;

  static TodoService get instance => _instance ??= TodoService._();

  TodoService._();

  Future<List<Todo>> getAll() async {
    final res = await http.get('$_BASE_URL', headers: _headers);
    if (res.statusCode == 200) {
      return Todo.fromJsonList(res.body);
    }
    return [];
  }

  Stream<List<Todo>> getAllAsStream() async* {
    final todos = await getAll();
    if (todos != null) {
      yield todos;
    }
  }
}
