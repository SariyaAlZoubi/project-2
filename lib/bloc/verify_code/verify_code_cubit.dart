import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/verify_code/verify_code_state.dart';
import 'package:untitled1/model/verify_code/verify_model.dart';
import '../../network/remote/http.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit() : super(InitState());

  static VerifyCodeCubit get(context) => BlocProvider.of(context);

  VerifyModel? verifyModel;

  Future verifyCode({required code, required phone}) async {
    emit(CodeLoadingState());
    await HttpHelper.postData(
        url: 'verifyCode',
        data: {'code': code, 'phone_number': phone}).then((value) async {
      verifyModel = VerifyModel.fromJson(jsonDecode(value.body));
      emit(CodeSuccessState(verifyModel!));
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(CodeErrorState());
    });
  }
}
