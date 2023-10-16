import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/models/salon_model.dart';

part 'salons_event.dart';
part 'salons_state.dart';

class SalonsBloc extends Bloc<SalonsEvent, SalonsState> {
  SalonsBloc() : super(SalonsInitial()) {
    on<GetSalonsEvent>((event, emit) {
      emit(LoadingSalons());
    });
  }
}
