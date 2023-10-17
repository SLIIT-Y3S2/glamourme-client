import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/models/salon_model.dart';
import 'package:flutter_app/repositories/salons/salon_repository.dart';

part 'salons_event.dart';
part 'salons_state.dart';

class SalonsBloc extends Bloc<SalonsEvent, SalonsState> {
  List<SalonModel> salonList = [];
  final SalonRepository _salonRepository = SalonRepository();
  SalonsBloc() : super(SalonsInitial()) {
    on<GetSalonsEvent>(_onGetSalonEventHandler);
  }

  //
  _onGetSalonEventHandler(
      GetSalonsEvent event, Emitter<SalonsState> emit) async {
    emit(LoadingSalons());
    await _salonRepository.getSalons().then((salons) {
      salonList = salons;
    }).catchError((error) {
      developer.log(error.toString());
    });

    emit(LoadedSalons(salons: salonList));
  }
}
