import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../network/remote/http.dart';
import '../get_store/get_store_cubit.dart';
import 'confirm_cart_with_same_location_state.dart';

class ConfirmCartWithSameLocationCubit
    extends Cubit<ConfirmCartWithSameLocationState> {
  ConfirmCartWithSameLocationCubit() : super(InitState());

  static ConfirmCartWithSameLocationCubit get(context) =>
      BlocProvider.of(context);

  Future confirmCart() async {
    emit(LoadingState());
    await HttpHelper.putData(url: 'confirmsCart', data: {'notes': "not found"})
        .then((value) {
      var response = jsonDecode(value.body);
      String message = response['message'];
      GetStoreCubit.num=0;
      emit(SuccessState(message));
    }).catchError((onError) {
      emit(ErrorState());
      if (kDebugMode) {
        print(onError.toString());
      }
    });
  }
}
