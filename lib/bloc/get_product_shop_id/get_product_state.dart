import '../../model/change_favorite_model.dart';
import '../../model/product/get_product_by_shop.dart';
import '../../model/store/add_store.dart';

abstract class GetProductByShopState {}

class GetProductByShopInitialState extends GetProductByShopState {}

class LoadingState extends GetProductByShopState {}

class SuccessState extends GetProductByShopState {
  GetProductModel? getProductModel;

  SuccessState(this.getProductModel);
}

class ErrorState extends GetProductByShopState {}

class ChangeFavouriteState extends GetProductByShopState {}

class SuccessChangeFavouriteState extends GetProductByShopState {
  final ChangeFavoritesModel model;

  SuccessChangeFavouriteState(this.model);
}

class ErrorFavoriteState extends GetProductByShopState {}

class AddProductLoadingState extends GetProductByShopState {}

class AddProductSuccessState extends GetProductByShopState {
  AddProductModel model;

  AddProductSuccessState(this.model);
}

class AddProductErrorState extends GetProductByShopState {}

class AddProductImageSuccess extends GetProductByShopState {}

class AddProductImageError extends GetProductByShopState {}

class OpenCloseLoadingState extends GetProductByShopState {}

class OpenCloseSuccessState extends GetProductByShopState {
  AddProductModel model;

  OpenCloseSuccessState(this.model);
}

class OpenCloseErrorState extends GetProductByShopState {}

class DeleteProductLoadingState extends GetProductByShopState {}

class DeleteProductSuccessState extends GetProductByShopState {
  AddProductModel model;

  DeleteProductSuccessState(this.model);
}

class DeleteProductErrorState extends GetProductByShopState {}
