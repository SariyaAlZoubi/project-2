import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/cart/cart_model.dart';
import '../../model/change_favorite_model.dart';
import '../../model/category/get_category.dart';
import '../../model/store/get_store_model.dart';
import '../../model/store/get_vendor_shop.dart';
import '../../model/store/shop_favorite.dart';
import '../../network/remote/http.dart';
import 'get_store_state.dart';

class GetStoreCubit extends Cubit<GetStoreState> {
  GetStoreCubit() : super(GetStoreInitial());

  static GetStoreCubit get(context) => BlocProvider.of(context);
  GetStoreModel? getStoreModel;

  CategoryModel? getCategoryModel;
  GetVendorShopModel? getVendorShopModel;

  Map<dynamic, dynamic> favourites = {};
  ChangeFavoritesModel? changeFavoritesModel;
  FavoriteStoreModel? getFavoriteModel;

  CartModel? cartModel;
  static int? num;

  void getCart() {
    emit(GetCartLoadingState());
    HttpHelper.getData(url: 'viewCart').then((value) {
      if (value.statusCode == 200) {
        cartModel = CartModel.fromJson(jsonDecode(value.body));
        if (cartModel?.message != null) {
          num = 0;
        } else {
          num = cartModel?.cartItems?.length;
        }

        emit(GetCartSuccessState());
      }
    }).catchError((onError) {
      emit(GetCartErrorState());
      if (kDebugMode) {
        print(onError.toString());
      }
    });
  }

  Future getStoreByCategory({required id}) async {
    getStoreModel = null;
    emit(LoadingState());
    await HttpHelper.getData(
      url: "getShopsByCategory/$id",
    ).then((value) {
      getStoreModel = GetStoreModel.fromJson(jsonDecode(value.body));

      getStoreModel?.shopsData?.forEach((element) {
        favourites.addAll({
          element.id: element.inFavorite,
        });
      });

      emit(SuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(ErrorState());
    });
  }

  Future changeFavourite({required id}) async {
    if (favourites[id] == 1) {
      favourites[id] = 0;
    } else {
      favourites[id] = 1;
    }
    emit(ChangeFavouriteState());

    await HttpHelper.postData(
      url: "addShopToFavorite/$id",
      data: null,
    ).then((value) {
      changeFavoritesModel =
          ChangeFavoritesModel.fromJson(jsonDecode(value.body));
      emit(SuccessChangeFavouriteState(changeFavoritesModel!));
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(ErrorChangeFavouriteState());
    });
  }

  Future getCategory() async {
    emit(LoadingState());
    await HttpHelper.getData(
      url: "getAllCategories",
    ).then((value) {
      getCategoryModel = CategoryModel.fromJson(jsonDecode(value.body));

      emit(SuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(ErrorState());
    });
  }

  Future getVendorShop() async {
    emit(LoadingState());
    await HttpHelper.getData(
      url: "getVendorShops",
    ).then((value) {
      getVendorShopModel = GetVendorShopModel.fromJson(jsonDecode(value.body));
      emit(SuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(ErrorState());
    });
  }

  Future getStoreFavorite() async {
    emit(GetFavoriteShopLoadingState());
    HttpHelper.getData(
      url: "getFavoriteShops",
    ).then((value) {
      getFavoriteModel = FavoriteStoreModel.fromJson(jsonDecode(value.body));

      emit(GetFavoriteShopSuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(GetFavoriteShopErrorState());
    });
  }

  int id = 1;

  void changeId(int id) {
    this.id = id;
    emit(StateBloc());
  }
}
