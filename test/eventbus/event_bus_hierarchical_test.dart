import 'package:test/test.dart';
import 'package:flutter_utils/flutter_utils.dart';

class SuperEvent {}

class EventA extends SuperEvent {
  String text;

  EventA(this.text);
}

class EventB extends SuperEvent {
  String text;

  EventB(this.text);
}

void main() {
  group('[EventBus] (hierarchical)', () {
    test('Listen on same class', () {
      final eventBus = EventBus();
      final f = eventBus.on<EventA>().toList();

      eventBus.publish(EventA('a1'));
      eventBus.publish(EventB('b1'));
      eventBus.dispose();

      return f.then((events) {
        expect(events.length, 1);
      });
    });

    test('Listen on superclass', () {
      final eventBus = EventBus();
      final f = eventBus.on<SuperEvent>().toList();

      eventBus.publish(EventA('a1'));
      eventBus.publish(EventB('b1'));
      eventBus.dispose();

      return f.then((events) {
        expect(events.length, 2);
      });
    });
  });
}
