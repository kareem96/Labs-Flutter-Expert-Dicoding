

part of "counter_cubit.dart";

class CounterState extends Equatable{
  int value = 0;
  CounterState(this.value);

  @override
  List<Object?> get props => [value];

}