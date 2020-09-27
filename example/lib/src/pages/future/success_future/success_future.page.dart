import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

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
