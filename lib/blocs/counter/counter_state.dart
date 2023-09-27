part of 'counter_bloc.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {
  CounterInitial();
}

class IncrementState extends CounterState {
  int value;
  IncrementState({required this.value});
}

class DecrementState extends CounterState {
  int value;
  DecrementState({required this.value});
}
