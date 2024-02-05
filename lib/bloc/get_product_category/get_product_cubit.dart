import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/category/get_category.dart';
import '../../model/change_favorite_model.dart';
import '../../model/product/get_favourite_model.dart';
import '../../model/product/get_product_by_category_model.dart';
import '../../network/remote/http.dart';
import 'get_product_state.dart';

class GetProductCubit extends Cubit<GetProductByCategoryState> {
  GetProductCubit() : super(GetProductInitialState());

  static GetProductCubit get(context) => BlocProvider.of(context);
  GetProductByCategoryModel? getProductModel;

  CategoryModel? getCategoryModel;
  Map<dynamic, dynamic> favourites = {};
  ChangeFavoritesModel? changeFavoritesModel;
  GetFavoriteModel? getFavouriteModel;

  Future getCategory() async {
    emit(GetProductCategoryLoadingState());
    await HttpHelper.getData(
      url: "getAllCategories",
    ).then((value) {
      getCategoryModel = CategoryModel.fromJson(jsonDecode(value.body));

      emit(GetProductCategorySuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(GetProductCategoryErrorState());
    });
  }

  Future getProductCategory({required id}) async {
    emit(GetProductCategoryLoadingState());
    await HttpHelper.getData(
      url: "getProductsByCategory/$id",
    ).then((value) {
      getProductModel =
          GetProductByCategoryModel.fromJson(jsonDecode(value.body));
      getProductModel?.productsData?.forEach((element) {
        favourites.addAll({
          element.id: element.inFavorite,
        });
      });

      emit(GetProductCategorySuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(GetProductCategoryErrorState());
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
      url: "addProductToFavorite/$id",
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

  Future getAllFavourite() async {
    emit(GetAllFavouriteLoadingState());
    await HttpHelper.getData(
      url: "getFavoriteProducts",
    ).then((value) {
      getFavouriteModel = GetFavoriteModel.fromJson(jsonDecode(value.body));

      emit(GetAllFavouriteSuccessState(getFavouriteModel));
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(GetAllFavouriteErrorState());
    });
  }
}
