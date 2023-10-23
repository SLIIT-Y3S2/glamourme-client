import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_app/models/location_model.dart';
import 'package:flutter_app/repositories/location/location_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<GetLocationEvent>((event, emit) async {
      final LocationRepository locationRepository = LocationRepository();
      emit(const GettingLocation());
      await locationRepository
          .getLocation()
          .then((value) => {
                emit(LocationLoaded(location: value)),
              })
          .catchError((error) {
        developer.log(
          error.toString(),
        );
        throw Exception(error.toString());
      });
    });
  }
}
