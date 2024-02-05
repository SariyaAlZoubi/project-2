import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/search_cubit/search_store_state.dart';

import '../../model/change_favorite_model.dart';
import '../../model/product/search_product_model.dart';
import '../../model/store/serach_store_model.dart';
import '../../network/remote/http.dart';

class SearchStoreCubit extends Cubit<SearchStoreState> {
  SearchStoreCubit() : super(SearchStoreInitial());

  static SearchStoreCubit get(context) => BlocProvider.of(context);

  SearchStoreModel? searchModel;

  SearchProductModel? searchProductModel;

  ChangeFavoritesModel? changeFavoritesModel;

  Map<dynamic, dynamic> favourites = {};

  Future searchByChar({required text}) async {
    emit(LoadingState());
    await HttpHelper.getData(
      url: "searchShop/$text",
    ).then((value) {
      searchModel = SearchStoreModel.fromJson(jsonDecode(value.body));
      emit(SuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(ErrorState());
    });
  }

  Future searchProduct({required text}) async {
    emit(SearchProductLoadingState());
    await HttpHelper.getData(
      url: "searchproduct/$text",
    ).then((value) {
      searchProductModel = SearchProductModel.fromJson(jsonDecode(value.body));

      searchProductModel?.productsData?.forEach((element) {
        favourites.addAll({
          element.id: element.inFavorite,
        });
      });

      emit(SearchProductSuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(SearchProductErrorState());
    });
  }

  Future changeFavourite({required id}) async {
    if (favourites[id] == 1) {
      favourites[id] = 0;
    } else {
      favourites[id] = 1;
    }
    emit(ChangeFavouriteState());

    HttpHelper.postData(
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
}
