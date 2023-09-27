import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<CounterEvent>((event, emit) {
      if (event is IncrementEvent) {
        int value = event.value;
        value++;
        emit(IncrementState(value: value));
      } else if (event is DecrementEvent) {
        int value = event.value;
        value--;
        emit(DecrementState(value: value));
      }
    });
  }
}
