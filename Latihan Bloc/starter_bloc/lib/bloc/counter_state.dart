

part of 'counter_bloc.dart';

class CounterState extends Equatable{
  CounterState(this.value);

  int value = 0;
  @override
  // TODO: implement props
  List<Object?> get props => [value];
}