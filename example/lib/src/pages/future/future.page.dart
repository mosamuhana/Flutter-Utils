import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

import 'success_future/success_future.page.dart';
import 'error_future/error_future.page.dart';
import 'todos/todos.page.dart';

class FuturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Future Examples')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 50,
              child: Center(
                child: CustomFutureBuilder<int>(
                  futureBuilder: () => _getData(),
                  initialBuilder: (_, start) => RaisedButton(child: Text('Success button'), onPressed: start),
                  busyBuilder: (_) => CircularProgressIndicator(),
                  dataBuilder: (_, data) => Text(data.toString()),
                ),
              ),
            ),
            Container(
              height: 50,
              child: Center(
                child: CustomFutureBuilder<int>(
                  futureBuilder: () => _getDataMaybeFailed(),
                  initialBuilder: (_, start) => RaisedButton(child: Text('Error button'), onPressed: start),
                  busyBuilder: (_) => CircularProgressIndicator(),
                  errorBuilder: (_, error, retry) => RaisedButton(child: Text('Sorry! Try again'), onPressed: retry),
                  dataBuilder: (_, data) => Text(data.toString()),
                ),
              ),
            ),
            RaisedButton(
              child: Text('Success example'),
              onPressed: () => _show(context, SuccessFuturePage()),
            ),
            RaisedButton(
              child: Text('Error example'),
              onPressed: () => _show(context, ErrorFuturePage()),
            ),
            RaisedButton(
              child: Text('Todos example (CustomFutureBuilder)'),
              onPressed: () => _show(context, TodosPage()),
            ),
          ],
        ),
      ),
    );
  }

  void _show(BuildContext context, Widget page) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));

  Future<int> _getData() async {
    await Future.delayed(const Duration(seconds: 1));
    return 42;
  }

  Future<int> _getDataMaybeFailed() async {
    await Future.delayed(const Duration(seconds: 1));
    if (Random().nextInt(3) == 1) {
      throw Exception('Some error occured');
    }
    return 10;
  }
}
