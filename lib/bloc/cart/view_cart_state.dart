abstract class CartState {}

class InitialState extends CartState {}

class GetCartLoadingState extends CartState {}

class GetCartSuccessState extends CartState {}

class GetCartErrorState extends CartState {}

class ConfirmCartLoadingState extends CartState {}

class ConfirmCartSuccessState extends CartState {
  final String message;

  ConfirmCartSuccessState(this.message);
}

class ConfirmCartErrorState extends CartState {}

class DeleteProductLoadingState extends CartState {}

class DeleteProductSuccessState extends CartState {}

class DeleteProductErrorState extends CartState {}

class ClearCartLoadingState extends CartState {}

class ClearCartSuccessState extends CartState {}

class ClearCartErrorState extends CartState {}

class UpdateQuantityLoadingState extends CartState {}

class UpdateQuantitySuccessState extends CartState {}

class UpdateQuantityErrorState extends CartState {}

class Success extends CartState {}

class EditPrice extends CartState {}
