import '../../model/change_favorite_model.dart';

abstract class SearchStoreState {}

class SearchStoreInitial extends SearchStoreState {}

class LoadingState extends SearchStoreState {}

class SuccessState extends SearchStoreState {}

class ErrorState extends SearchStoreState {}

class SearchProductLoadingState extends SearchStoreState {}

class SearchProductSuccessState extends SearchStoreState {}

class SearchProductErrorState extends SearchStoreState {}

class ImageSuccess extends SearchStoreState {}

class ImageError extends SearchStoreState {}

class ChangeFavouriteState extends SearchStoreState {}

class SuccessChangeFavouriteState extends SearchStoreState {
  final ChangeFavoritesModel model;

  SuccessChangeFavouriteState(this.model);
}

class ErrorChangeFavouriteState extends SearchStoreState {}
