abstract class ConfirmCartWithSameLocationState {}

class InitState extends ConfirmCartWithSameLocationState {}

class LoadingState extends ConfirmCartWithSameLocationState {}

class SuccessState extends ConfirmCartWithSameLocationState {
  String message;

  SuccessState(this.message);
}

class ErrorState extends ConfirmCartWithSameLocationState {}
