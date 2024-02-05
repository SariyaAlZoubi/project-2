import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../bloc/map/map_cubit.dart';
import '../../bloc/map/map_state.dart';

class Map extends StatelessWidget {
  const Map(this.id, {super.key});

 final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => MapCubit()..getMap(id: id),
            child: BlocConsumer<MapCubit, MapState>(
              listener: (context, state) {},
              builder: (context, state) {
                MapCubit mapCubit = MapCubit.get(context);
                return mapCubit.mapModel != null
                    ? GoogleMap(
                        mapType: MapType.normal,
                        markers: mapCubit.markers!,
                        initialCameraPosition: mapCubit.kGooglePlex!)
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
            )));
  }
}
