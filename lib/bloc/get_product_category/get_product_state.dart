import '../../model/change_favorite_model.dart';
import '../../model/product/get_favourite_model.dart';

abstract class GetProductByCategoryState {}

class GetProductInitialState extends GetProductByCategoryState {}

class GetProductCategoryLoadingState extends GetProductByCategoryState {}

class GetProductCategorySuccessState extends GetProductByCategoryState {}

class GetProductCategoryErrorState extends GetProductByCategoryState {}

class GetCategoryLoadingState extends GetProductByCategoryState {}

class GetCategorySuccessState extends GetProductByCategoryState {}

class GetCategoryErrorState extends GetProductByCategoryState {}

class ChangeFavouriteState extends GetProductByCategoryState {}

class SuccessChangeFavouriteState extends GetProductByCategoryState {
  final ChangeFavoritesModel model;

  SuccessChangeFavouriteState(this.model);
}

class ErrorChangeFavouriteState extends GetProductByCategoryState {}

class GetAllFavouriteLoadingState extends GetProductByCategoryState {}

class GetAllFavouriteSuccessState extends GetProductByCategoryState {
  GetFavoriteModel? getFavouriteModel;

  GetAllFavouriteSuccessState(this.getFavouriteModel);
}

class GetAllFavouriteErrorState extends GetProductByCategoryState {}
