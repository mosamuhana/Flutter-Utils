import 'package:flutter/material.dart';

import '../future/future.page.dart';
import '../eventbus/eventbus.page.dart';
import '../stream/stream.page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Utils Examples')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Event Bus'),
              onPressed: () => _show(context, EventbusPage()),
            ),
            SizedBox(height: 10),
            RaisedButton(
              child: Text('Streams'),
              onPressed: () => _show(context, StreamPage()),
            ),
            SizedBox(height: 10),
            RaisedButton(
              child: Text('Futures'),
              onPressed: () => _show(context, FuturePage()),
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
