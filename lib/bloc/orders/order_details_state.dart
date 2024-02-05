abstract class OrderDetailsState {}

class InitialState extends OrderDetailsState {}

class LoadingState extends OrderDetailsState {}

class SuccessState extends OrderDetailsState {}

class ErrorState extends OrderDetailsState {}

class StartDeliveryLoadingState extends OrderDetailsState {}

class StartDeliverySuccessState extends OrderDetailsState {
  String message;

  StartDeliverySuccessState(this.message);
}

class StartDeliveryErrorState extends OrderDetailsState {}
