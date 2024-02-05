import '../../model/store/add_store.dart';

abstract class AddStoreState {}

class AddStoreInitialState extends AddStoreState {}

class DropList extends AddStoreState {}

class LoadingState extends AddStoreState {}

class SuccessState extends AddStoreState {
  AddProductModel model;

  SuccessState(this.model);
}

class ErrorState extends AddStoreState {}

class ImageSuccess extends AddStoreState {}

class ImageError extends AddStoreState {}

class Error extends AddStoreState {}

class Success extends AddStoreState {}

class Loading extends AddStoreState {}
