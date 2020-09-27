# flutter_utils

Some tools for flutter.

## EventBus

A simple Event Bus using Dart [Streams](https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/dart:async.Stream).

```dart
final eventBus = EventBus();

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  static const COUNTER = 'COUNTER';

  StreamSubscription<int> sub;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    sub = eventBus.subscribe<int>((v) {
      setState(() => _counter = v);
    }, name: COUNTER);
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter:'),
            Text('$_counter', style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
      floatingActionButton: _floatingActionButton,
    );
  }

  Widget get _floatingActionButton {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          color: Colors.red,
          onPressed: _counter > 0 ? () => eventBus.publish(_counter - 1, name: COUNTER) : null,
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.add),
          color: Colors.green,
          onPressed: _counter < 10 ? () => eventBus.publish(_counter + 1, name: COUNTER) : null,
        ),
      ],
    );
  }
}
```

## CustomFutureBuilder

```dart
class ErrorFuturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Error Example')),
      body: Center(
        child: CustomFutureBuilder.autoStart(
          futureBuilder: () => _getDataMaybeFailed(),
          busyBuilder: (_) => CircularProgressIndicator(),
          errorBuilder: (_, error, retry) => Text('${error.toString()}'),
          dataBuilder: (_, data) => Text(data.toString()),
          onError: (error, retry) async {
            final res = await _showError(context, '${error.toString()} \nSorry! Try again?');
            if (res) {
              retry();
            }
          },
        ),
      ),
    );
  }

  Future<bool> _showError(BuildContext context, String message) async {
    final res = await showDialog<bool>(
      context: context,
      child: AlertDialog(
        content: Text(message),
        actions: [
          FlatButton(
            child: Text(message),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    return res ?? false;
  }

  Future<int> _getDataMaybeFailed() async {
    await Future.delayed(const Duration(seconds: 1));
    if (Random().nextInt(3) == 1) {
      throw Exception('Some error occured');
    }
    return 10;
  }
}
```

```dart
class SuccessFuturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Success Example')),
      body: Center(
        child: CustomFutureBuilder.autoStart(
          futureBuilder: () => _getData(),
          busyBuilder: (_) => CircularProgressIndicator(),
          dataBuilder: (_, data) => Text('Data is $data'),
        ),
      ),
    );
  }

  Future<int> _getData() async {
    await Future.delayed(const Duration(seconds: 1));
    return 42;
  }
}
```

## CustomStreamBuilder

```dart
class CustomStreamBuilderPage extends StatelessWidget {
  final testStream = Stream<int>.periodic(Duration(seconds: 1), (x) => (x == 4) ? throw Exception('oops') : x).take(5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CustomStreamBuilder Example')),
      body: Center(
        child: CustomStreamBuilder<int>(
          stream: testStream,
          onData: (data) => print(data),
          onError: (error) => Alert.show(context, error.toString()),
          onDone: () => print('Done!'),
          busyBuilder: (_) => CircularProgressIndicator(),
          dataBuilder: (_, data) => Text('$data'),
          errorBuilder: (_, error) => Text(error.toString()),
        ),
      ),
    );
  }
}
```

## StreamListener

```dart
class Todo {
  final String title;
  final bool completed;
  Todo({this.title, this.completed = false});
}

final _todos = <Todo>[
  Todo(title: 'Item 1'),
  Todo(title: 'Item 2'),
  Todo(title: 'Item 3'),
];

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
          //stream: TodoService.instance.getAllAsStream(),
          stream: getTodos(),
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

  Stream<List<Todo>> getTodos() async* {
    await Future.delayed(Duration(seconds: 1));
    yield _todos;
  }
}
```