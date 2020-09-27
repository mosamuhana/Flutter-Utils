import 'package:flutter/material.dart';

import 'stream_listener/stream_listener.page.dart';
import 'custom_stream_builder/custom_stream_builder.page.dart';

class StreamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stream Examples')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Streamer Example'),
              onPressed: () => _show(context, CustomStreamBuilderPage()),
            ),
            SizedBox(height: 10),
            RaisedButton(
              child: Text('StreamListener Example'),
              onPressed: () => _show(context, StreamListenerPage()),
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
