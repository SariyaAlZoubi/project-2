import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/store/get_shop_info.dart';
import '../../network/remote/http.dart';
import 'get_shop_info_state.dart';

class GetShopInfoCubit extends Cubit<GetShopInfoState> {
  GetShopInfoCubit() : super(GetShopInfoInitial());

  static GetShopInfoCubit get(context) => BlocProvider.of(context);
  GetShopInfoModel? getShopInfoModel;

  Future getShopInfo({required id}) async {
    emit(LoadingState());
    await HttpHelper.getData(
      url: "getshopinfo/$id",
    ).then((value) {
      getShopInfoModel = GetShopInfoModel.fromJson(jsonDecode(value.body));

      emit(SuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(ErrorState());
    });
  }
}
