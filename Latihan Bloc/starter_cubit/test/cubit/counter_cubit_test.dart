import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_cubit/cubit/counter_cubit.dart';

void main() {
  late CounterCubit counterCubit;

  setUp(() {
    counterCubit = CounterCubit();
  });

  test("Initial state should be CounterState(0)", () {
    expect(counterCubit.state, CounterState(0));
  });

  blocTest<CounterCubit, CounterState>(
      "should emit CounterState(1) when Increment event is added",
      build: () => counterCubit,
      act: (cubit) => cubit.increment(),
      expect: () => [
            CounterState(1),
          ]);

  blocTest<CounterCubit, CounterState>(
      "should emit CounterState(-1) when Decrement event is added",
      build: () => counterCubit,
      act: (cubit) => cubit.decrement(),
      expect: () => [
            CounterState(-1),
          ]);
}
