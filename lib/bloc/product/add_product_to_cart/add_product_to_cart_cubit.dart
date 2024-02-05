import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/get_store/get_store_cubit.dart';

import '../../../network/remote/http.dart';
import 'add_product_to_cart_state.dart';

class AddProductToCartCubit extends Cubit<AddProductToCartState> {
  AddProductToCartCubit() : super(InitialState());

  static AddProductToCartCubit get(context) => BlocProvider.of(context);
  String? message;

  Future addProductToCart({required id, required quantity}) async {
    emit(AddProductToCartLoadingState());

    await HttpHelper.postData(url: 'addProductToCart', data: {
      'customer_id': "1",
      'product_id': "$id",
      'quantity_req': "$quantity"
    }).then((value) {
      if (value.statusCode == 200) {
        var response = jsonDecode(value.body);
        message = response['message'];
        GetStoreCubit.num=GetStoreCubit.num!+1;
        emit(AddProductToCartSuccessState(message!));
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
    });
  }
}
