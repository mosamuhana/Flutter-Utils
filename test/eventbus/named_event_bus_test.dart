import 'dart:async';

import 'package:test/test.dart';
import 'package:flutter_utils/flutter_utils.dart';

void main() {
  group('[Named EventBus]', () {
    test('Fire one event', () {
      final eventBus = EventBus();
      final f = eventBus.on('message').toList();

      eventBus.publish('hello', name: 'message');
      eventBus.dispose();

      return f.then((events) {
        expect(events.length, 1);
        expect(events[0], 'hello');
      });
    });

    test('Fire typed event', () {
      final eventBus = EventBus();
      final f = eventBus.on<User>(USER_CREATE).toList();

      final user = User(id: 1, name: 'Sam');

      eventBus.publish(user, name: USER_CREATE);
      eventBus.dispose();

      return f.then((events) {
        expect(events.length, 1);
        expect(events[0] is User, true);
      });
    });

    test('Use subscribe', () {
      final eventBus = EventBus();
      StreamSubscription sub;

      sub = eventBus.subscribe((e) {
        expect(e is User, true);
        expect(e.name, 'Sam');
        sub.cancel();
      }, name: USER_CREATE);

      final user = User(id: 1, name: 'Sam');

      eventBus.publish<User>(user, name: USER_CREATE);
      eventBus.dispose();
    });
  });
}

class User {
  final int id;
  final String name;
  User({this.id, this.name});
}

const USER_CREATE = 'user.create';
