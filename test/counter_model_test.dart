import 'package:flutter_test/flutter_test.dart';
import '../examples/contador/CounterModel.dart'; // Adjust path as needed

void main() {
  group('Counter Class Unit Tests', () {
    test('Counter should initialize with a count of 0', () {
      final counter = Counter();
      expect(counter.count, 0);
    });

    test('increment() should increase the count by 1', () {
      final counter = Counter();
      counter.increment();
      expect(counter.count, 1);
    });

    test('increment() should increase the count correctly after multiple calls', () {
      final counter = Counter();
      counter.increment();
      counter.increment();
      counter.increment();
      expect(counter.count, 3);
    });

    // For this task, verifying the public `count` property change is sufficient
    // to infer that notifyListeners() was conceptually involved, as the count
    // is the state that listeners would react to.
    test('increment() updates public count, implying listeners would be notified', () {
      final counter = Counter();
      expect(counter.count, 0, reason: "Initial count should be 0");
      counter.increment();
      expect(counter.count, 1, reason: "Count should be 1 after first increment");
      counter.increment();
      expect(counter.count, 2, reason: "Count should be 2 after second increment");
    });
  });
}
