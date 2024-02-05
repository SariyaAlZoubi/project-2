import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/register/register_state.dart';

import '../../model/register/register_model.dart';
import '../../network/local/cache.dart';
import '../../network/remote/http.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  int values = -1;

  var firebase = FirebaseMessaging.instance;
  String? deviceToken;

  void getDeviceToken() {
    firebase.getToken().then((value) {
      deviceToken = value;
      if (kDebugMode) {
        print(value);
        print('=========================================');
      }

    });
  }

  RegisterModel? registerModel;

  Future register(
      {required phoneNumber, required name, required password}) async {
    values == -1
        ? CacheHelper.saveData(key: 'type', value: 'customer')
        : CacheHelper.saveData(key: 'type', value: 'vendor');
    emit(LoadingState());
    await HttpHelper.postData(
            url: 'signup',
            data: values == -1
                ? {
                    'type': values == -1 ? 'customer' : 'vendor',
                    'name': name,
                    'phone_number': phoneNumber,
                    'password': password,
                    "device_token": deviceToken
                  }
                : {
                    'type': values == -1 ? 'customer' : 'vendor',
                    'phone_number': phoneNumber,
                    'password': password
                  })
        .then((value) async {
      registerModel = RegisterModel.fromJson(jsonDecode(value.body));

      if (registerModel!.token != null) {
        await CacheHelper.saveData(key: 'token', value: registerModel!.token);
      }
      emit(SuccessState(registerModel!));
    }).catchError((onError) {
      emit(ErrorState());
      if (kDebugMode) {
        print(onError.toString());
      }
    });
  }

  void removeField() {
    emit(RemoveField());
  }
}
