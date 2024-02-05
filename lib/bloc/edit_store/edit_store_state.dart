import '../../model/store/add_store.dart';

abstract class EditStoreState {}

class EditStoreInitialState extends EditStoreState {}

class EditStoreLoadingState extends EditStoreState {}

class EditStoreDropList extends EditStoreState {}

class EditStoreSuccessState extends EditStoreState {
  AddProductModel model;

  EditStoreSuccessState(this.model);
}

class EditStoreErrorState extends EditStoreState {}

class EditStoreImageSuccessState extends EditStoreState {}

class EditStoreImageErrorState extends EditStoreState {}

class LoadingState extends EditStoreState {}

class SuccessState extends EditStoreState {}

class ErrorState extends EditStoreState {}
