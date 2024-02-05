import '../../../model/product/product_details.dart';

abstract class ProductDetailsState {}

class InitialState extends ProductDetailsState {}

class LoadingState extends ProductDetailsState {}

class SuccessState extends ProductDetailsState {
  ProductDetailsModel productDetailsModel;

  SuccessState(this.productDetailsModel);
}

class ErrorState extends ProductDetailsState {}

class CountState extends ProductDetailsState {}
