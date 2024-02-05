import '../../model/change_favorite_model.dart';

abstract class GetStoreState {}

class GetStoreInitial extends GetStoreState {}

class LoadingState extends GetStoreState {}

class SuccessState extends GetStoreState {}

class ErrorState extends GetStoreState {}

class GetCartLoadingState extends GetStoreState {}

class GetCartSuccessState extends GetStoreState {}

class GetCartErrorState extends GetStoreState {}

class ChangeFavouriteState extends GetStoreState {}

class SuccessChangeFavouriteState extends GetStoreState {
  final ChangeFavoritesModel model;

  SuccessChangeFavouriteState(this.model);
}

class ErrorChangeFavouriteState extends GetStoreState {}

class GetFavoriteShopLoadingState extends GetStoreState {}

class GetFavoriteShopSuccessState extends GetStoreState {}

class GetFavoriteShopErrorState extends GetStoreState {}

class StateBloc extends GetStoreState {}
