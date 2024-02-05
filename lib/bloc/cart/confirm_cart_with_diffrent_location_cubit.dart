import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/get_store/get_store_cubit.dart';
import '../../network/remote/http.dart';
import 'confirm_cart_with_different_location_state.dart';

class ConfirmCartWithDifferentLocationCubit
    extends Cubit<ConfirmCartWithDifferentLocationState> {
  ConfirmCartWithDifferentLocationCubit() : super(InitState());

  static ConfirmCartWithDifferentLocationCubit get(context) =>
      BlocProvider.of(context);

  Future confirmCart() async {
    emit(LoadingState());
    await HttpHelper.putData(url: 'confirmsCart', data: {'notes': "not found"})
        .then((value) {
      var response = jsonDecode(value.body);
      GetStoreCubit.num=0;
      String message = response['message'];

      emit(SuccessState(message));
    }).catchError((onError) {
      emit(ErrorState());
      if (kDebugMode) {
        print(onError.toString());
      }
    });
  }
}
