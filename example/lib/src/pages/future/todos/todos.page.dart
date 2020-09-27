import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

import '../../../services.dart';
import '../../../models.dart';

class TodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos Example')),
      body: Center(
        child: CustomFutureBuilder.autoStart(
          futureBuilder: () => TodoService.instance.getAll(),
          dataBuilder: _buildTodos,
        ),
      ),
    );
  }

  Widget _buildTodos(BuildContext context, List<Todo> todos) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return ListTile(
          title: Text(todo.title),
        );
      },
    );
  }
}
