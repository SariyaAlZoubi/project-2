abstract class AddProductToCartState {}

class InitialState extends AddProductToCartState {}

class AddProductToCartLoadingState extends AddProductToCartState {}

class AddProductToCartSuccessState extends AddProductToCartState {
  String message;

  AddProductToCartSuccessState(this.message);
}

class ErrorState extends AddProductToCartState {}

class CountState extends AddProductToCartState {}
