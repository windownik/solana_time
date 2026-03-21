import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:solana_time/data/sources/local_time_source.dart';


///
///
///
/// I make this code with OpenAi
///
/// Prompts:
/// How to write tests on dart?
/// How to best test my LocalTimeApi?
/// What are methods like expect in dart?
///
///

void main() {
  group('LocalTimeApi Tests', () {
    late LocalTimeApi localTimeApi;

    setUp(() {
      localTimeApi = LocalTimeApi();
    });

    tearDown(() {
      localTimeApi.cancel();
    });

    test('startLocalStream and check type of stream data', () async {
      final stream = localTimeApi.startLocalStream();
      final value = await stream.first.timeout(
        const Duration(seconds: 2),
      );
      expect(value, isA<DateTime>());
    });

    test('stream produces multiple values', () async {
      final stream = localTimeApi.startLocalStream();

      final events = <DateTime>[];
      final subscription = stream.listen((value) {
        events.add(value);
      });

      await Future.delayed(const Duration(seconds: 3));
      await subscription.cancel();
      expect(events.length >= 2, true);
    });

    test('cancel() stops the stream', () async {
      final stream = localTimeApi.startLocalStream();
      final events = <DateTime>[];

      final subscription = stream.listen((value) {
        events.add(value);
      });

      await Future.delayed(const Duration(milliseconds: 1500));

      final countBeforeCancel = events.length;
      localTimeApi.cancel();

      await Future.delayed(const Duration(seconds: 1));
      await subscription.cancel();
      expect(events.length, countBeforeCancel);
    });

  });
}
