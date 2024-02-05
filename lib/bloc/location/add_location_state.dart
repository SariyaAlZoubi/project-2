abstract class AddLocationState {}

class InitialState extends AddLocationState {}

class LoadingState extends AddLocationState {}

class AddLocationSuccessState extends AddLocationState {
  double longitude, latitude;

  AddLocationSuccessState(this.longitude, this.latitude);
}

class ErrorState extends AddLocationState {}

class GetLocationLoadingState extends AddLocationState {}

class GetLocationSuccessState extends AddLocationState {
  double longitude, latitude;

  GetLocationSuccessState(this.longitude, this.latitude);
}
