import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

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
