import 'package:flutter/material.dart';

import 'counter/counter.page.dart';

class EventbusPage extends StatelessWidget {
  const EventbusPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event Bus Examples')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Counter'),
              onPressed: () => _show(context, CounterPage()),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _show(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }
}
