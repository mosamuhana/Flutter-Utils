import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

import '../../../widgets.dart';

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
