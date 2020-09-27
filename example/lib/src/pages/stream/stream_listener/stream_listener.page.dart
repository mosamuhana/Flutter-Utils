import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

import '../../../services.dart';
import '../../../models.dart';

class StreamListenerPage extends StatefulWidget {
  @override
  _StreamListenerPageState createState() => _StreamListenerPageState();
}

class _StreamListenerPageState extends State<StreamListenerPage> {
  List<Todo> todos;
  dynamic error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('StreamListener Example')),
      body: Center(
        child: StreamListener<List<Todo>>(
          stream: TodoService.instance.getAllAsStream(),
          onData: (data) => todos = data ?? [],
          onError: (err) => error = err,
          onDone: () => setState(() {}),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (error != null) {
      return Center(child: Text('Error: ${error.toString()}'));
    }
    if (todos != null) {
      return _buildTodos;
    }

    return Center(child: CircularProgressIndicator());
  }

  Widget get _buildTodos {
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
