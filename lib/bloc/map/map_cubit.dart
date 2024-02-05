import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import '../../model/map/map_model.dart';
import '../../network/remote/http.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(InitialState());

  static MapCubit get(context) => BlocProvider.of(context);
  MapModel? mapModel;
  CameraPosition? kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Set<Marker>? markers = {};

  String generateRandomString(int len) {
    var r = Random();
    String randomString =
        String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
    return randomString;
  }

  Future getMap({required id}) async {
    emit(LoadingState());
    await HttpHelper.getData(url: 'get_shop_name_and_location/$id')
        .then((value) {
      mapModel = MapModel.fromJson(jsonDecode(value.body));
      double lat = double.parse(mapModel!.customerLocation!.latitude!);
      double long = double.parse(mapModel!.customerLocation!.longitude!);
      kGooglePlex = CameraPosition(
        target: LatLng(lat, long),
        zoom: 16.4746,
      );

      Marker marker = Marker(
          markerId: const MarkerId('1'),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(title: mapModel!.customerName));

      markers!.add(marker);

      for (var element in mapModel!.shopNameAndLocation!) {
        double lat = double.parse(element.latitude!);
        double long = double.parse(element.longitude!);
        Marker marker = Marker(
          markerId: MarkerId(generateRandomString(20)),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(title: element.name),
        );
        markers!.add(marker);
      }
      emit(SuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(ErrorState());
    });
  }
}
