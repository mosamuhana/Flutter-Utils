import 'dart:async';

import 'package:flutter/material.dart';

class QuestionAlert<T> extends StatelessWidget {
  final String message;
  final List<QuestionButtonData<T>> buttons;

  const QuestionAlert({
    Key key,
    @required this.message,
    @required this.buttons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: [
        for (var b in buttons)
          FlatButton(
            child: Text(b.title),
            onPressed: () async {
              Navigator.of(context).pop<T>(await _getValue(b));
            },
          ),
      ],
    );
  }

  Future<T> _getValue(QuestionButtonData<T> b) async {
    var result = b.value ?? b.callback?.call();
    if (result is Future) {
      return await result;
    }
    return result;
  }

  static Future<T> show<T>(BuildContext context, {String message, List<QuestionButtonData<T>> buttons}) async {
    return await showDialog<T>(
      context: context,
      child: QuestionAlert<T>(
        message: message,
        buttons: buttons,
      ),
    );
  }
}

class QuestionButtonData<T> {
  final String title;
  final FutureOr<T> value;
  final FutureOr<T> Function() callback;
  QuestionButtonData({this.title, this.value, this.callback}) : assert((value != null) ^ (callback != null));
}
