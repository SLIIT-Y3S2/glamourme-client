import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/location/location_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearYouSalonsMap extends StatefulWidget {
  const NearYouSalonsMap({super.key});

  @override
  State<NearYouSalonsMap> createState() => _NearYouSalonsMapState();
}

class _NearYouSalonsMapState extends State<NearYouSalonsMap> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return state is LocationLoaded
            ? SizedBox(
                height: 500,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      state.location.latitude,
                      state.location.longitude,
                    ),
                    zoom: 15,
                  ),
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
    );
  }
}
