abstract class ConfirmCartWithDifferentLocationState {}

class InitState extends ConfirmCartWithDifferentLocationState {}

class LoadingState extends ConfirmCartWithDifferentLocationState {}

class SuccessState extends ConfirmCartWithDifferentLocationState {
  String message;

  SuccessState(this.message);
}

class ErrorState extends ConfirmCartWithDifferentLocationState {}
