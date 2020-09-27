import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final String message;
  final String buttonText;

  const Alert({
    Key key,
    @required this.message,
    this.buttonText = 'OK',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: [
        FlatButton(
          child: Text(buttonText),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }

  static Future<void> show(BuildContext context, String message, {String buttonText = 'OK'}) async {
    await showDialog(
      context: context,
      child: Alert(
        message: message,
        buttonText: buttonText,
      ),
    );
  }
}
