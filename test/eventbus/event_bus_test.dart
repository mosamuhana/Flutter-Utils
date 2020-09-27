import 'dart:async';

import 'package:test/test.dart';
import 'package:flutter_utils/flutter_utils.dart';

class EventA {
  String text;
  EventA(this.text);
}

class EventB {
  String text;
  EventB(this.text);
}

class EventWithMap {
  Map myMap;
  EventWithMap(this.myMap);
}

void main() {
  group('[EventBus]', () {
    test('Fire one event', () {
      final eventBus = EventBus();
      final f = eventBus.on<EventA>().toList();

      eventBus.publish(EventA('a1'));
      eventBus.dispose();

      return f.then((events) {
        expect(events.length, 1);
      });
    });

    test('Fire two events of same type', () {
      final eventBus = EventBus();
      final f = eventBus.on<EventA>().toList();

      eventBus.publish(EventA('a1'));
      eventBus.publish(EventA('a2'));
      eventBus.dispose();

      return f.then((events) {
        expect(events.length, 2);
      });
    });

    test('Fire events of different type', () {
      final eventBus = EventBus();
      final f1 = eventBus.on<EventA>().toList();
      final f2 = eventBus.on<EventB>().toList();

      eventBus.publish(EventA('a1'));
      eventBus.publish(EventB('b1'));
      eventBus.dispose();

      return Future.wait([
        f1.then((events) {
          expect(events.length, 1);
        }),
        f2.then((events) {
          expect(events.length, 1);
        })
      ]);
    });

    test('Fire events of different type, receive all types', () {
      final eventBus = EventBus();
      final f = eventBus.on().toList();

      eventBus.publish(EventA('a1'));
      eventBus.publish(EventB('b1'));
      eventBus.publish(EventB('b2'));
      eventBus.dispose();

      return f.then((events) {
        expect(events.length, 3);
      });
    });

    test('Fire event with a map type', () {
      final eventBus = EventBus();
      final f = eventBus.on<EventWithMap>().toList();

      eventBus.publish(EventWithMap({'a': 'test'}));
      eventBus.dispose();

      return f.then((events) {
        expect(events.length, 1);
      });
    });
  });
}
