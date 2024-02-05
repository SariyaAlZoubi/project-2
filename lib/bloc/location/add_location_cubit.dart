import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../model/location/add_location_model.dart';
import '../../network/remote/http.dart';
import 'add_location_state.dart';

class AddLocationCubit extends Cubit<AddLocationState> {
  AddLocationCubit() : super(InitialState());

  static AddLocationCubit get(context) => BlocProvider.of(context);

  AddLocationModel? addLocationModel;
  double? longitude, latitude;

  Future addLocation() async {
    emit(LoadingState());
    await HttpHelper.postData(url: 'addLocation', data: {
      "city": "dsd",
      "latitude": "$latitude",
      "longitude": "$longitude"
    }).then((value) {
      emit(AddLocationSuccessState(longitude!, latitude!));
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
    });
  }

  Future getLocation() async {
    emit(GetLocationLoadingState());
    Position position;
    await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;
    emit(GetLocationSuccessState(latitude!, longitude!));
  }
}
