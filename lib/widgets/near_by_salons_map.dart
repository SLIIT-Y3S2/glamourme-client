import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/location/location_bloc.dart';
import 'package:flutter_app/blocs/salons/salons_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearYouSalonsMap extends StatefulWidget {
  const NearYouSalonsMap({super.key});

  @override
  State<NearYouSalonsMap> createState() => _NearYouSalonsMapState();
}

class _NearYouSalonsMapState extends State<NearYouSalonsMap> {
  final Map<String, LatLng> latLngList = {};

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SalonsBloc, SalonsState>(listener: (context, state) {
          if (state is LoadedSalons) {
            for (var salon in state.salons) {
              setState(() {
                latLngList[salon.salonName] = LatLng(
                  salon.latitude,
                  salon.longitude,
                );
              });
            }
          }
        }),
      ],
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return state is LocationLoaded
              ? SizedBox(
                  height: 500,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    gestureRecognizers: {
                      Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer()),
                    },
                    circles: {
                      Circle(
                        circleId: const CircleId('userLocation'),
                        center: LatLng(
                          state.location.latitude,
                          state.location.longitude,
                        ),
                        radius: 6000,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .copyWith(
                              primary: const Color.fromARGB(255, 37, 191, 230),
                            )
                            .primary
                            .withOpacity(0.4),
                        strokeColor: Theme.of(context)
                            .colorScheme
                            .copyWith(
                              primary: const Color.fromARGB(255, 37, 191, 230),
                            )
                            .primary
                            .withOpacity(0.4),
                      ),
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        state.location.latitude,
                        state.location.longitude,
                      ),
                      zoom: 12,
                    ),
                    markers: {
                      for (var entry in latLngList.entries)
                        Marker(
                          markerId: MarkerId(entry.key),
                          position: entry.value,
                          infoWindow: InfoWindow(
                            title: entry.key,
                          ),
                        ),
                    },
                  ),
                )
              : state is GettingLocation
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Center(
                      child: Text('Something went wrong'),
                    );
        },
      ),
    );
  }
}
