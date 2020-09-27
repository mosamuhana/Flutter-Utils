import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

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
