import 'package:flutter_utils/flutter_utils.dart';

class Events {
  static const COUNTER = 'COUNTER';

  static EventBus _instance;
  static EventBus get eventBus => _instance ??= EventBus();

  const Events._();
}
