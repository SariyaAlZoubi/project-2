import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/cart/view_cart_state.dart';
import 'package:untitled1/bloc/get_store/get_store_cubit.dart';


import '../../model/cart/cart_model.dart';
import '../../network/local/cache.dart';
import '../../network/remote/http.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(InitialState());

  static CartCubit get(context) => BlocProvider.of(context);

  CartModel? cartModel;
  bool isChangeIcon = false;

  Future getCart() async {
    emit(GetCartLoadingState());
    await HttpHelper.getData(url: 'viewCart').then((value) {
      if (value.statusCode == 200) {
        cartModel = CartModel.fromJson(jsonDecode(value.body));
        emit(GetCartSuccessState());
      }
    }).catchError((onError) {
      emit(GetCartErrorState());
      if (kDebugMode) {
        print(onError.toString());
      }
    });
  }


  int id1 = 0;

  Future deleteProductFromCart({required id}) async {
    id1 = id;
    emit(DeleteProductLoadingState());
    await HttpHelper.deleteData(
        url: 'removeProductFromCart',
        data: {'product_id': "$id"}).then((value) {
      if (value.statusCode == 200) {
        cartModel!.cartItems!.removeWhere((element) => element.productId == id);
        GetStoreCubit.num=GetStoreCubit.num!-1;
        emit(DeleteProductSuccessState());
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(DeleteProductErrorState());
    });
  }

  Future clearCart() async {
    String id = CacheHelper.getData(key: "id").toString();
    emit(ClearCartLoadingState());
    await HttpHelper.deleteData(url: 'clearCart', data: {'customer_id': id})
        .then((value) {
      cartModel!.cartItems!.length = 0;
      GetStoreCubit.num=0;
      emit(ClearCartSuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(ClearCartErrorState());
    });
  }

  Future updateProductQuantityInCart({required id, required quantity}) async {
    emit(UpdateQuantityLoadingState());
    await HttpHelper.postData(
        url: 'updateProductQuantityInCart',
        data: {'product_id': "$id", 'quantity': "$quantity"}).then((value) {
      emit(UpdateQuantitySuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(UpdateQuantityErrorState());
    });
  }

  void updatePrice(CartModel cartModel) {
    CartItems cartItems =
        cartModel.cartItems!.firstWhere((element) => element.productId == id1);
    double productPrice = double.parse(cartItems.productPrice!);
    double deliveryPrice = double.parse(cartModel.deliveryValue!);
    cartModel.totalPrice =
        cartModel.totalPrice! - productPrice * cartItems.quantity!;
    cartModel.total = cartModel.totalPrice! + deliveryPrice;
    emit(EditPrice());
  }

  void changeQuantity(String type, CartItems cartItems, CartModel cartModel) {
    if (type == 'add') {
      if (cartItems.totalQuantity! > cartItems.quantity!) {
        cartItems.quantity = cartItems.quantity! + 1;
        double productPrice = double.parse(cartItems.productPrice!);
        cartModel.totalPrice = cartModel.totalPrice! + productPrice;
        cartModel.total = cartModel.total! + productPrice;
        emit(Success());
      }
    } else {
      if (cartItems.quantity! > 1) {
        cartItems.quantity = cartItems.quantity! - 1;
        double productPrice = double.parse(cartItems.productPrice!);
        cartModel.totalPrice = cartModel.totalPrice! - productPrice;
        cartModel.total = cartModel.total! - productPrice;
        emit(Success());
      }
    }
  }
}
