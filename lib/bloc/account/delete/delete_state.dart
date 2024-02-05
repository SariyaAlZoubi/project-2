abstract class DeleteAccountState {}

class InitialState extends DeleteAccountState {}

class DeleteLoadingState extends DeleteAccountState {}

class DeleteSuccessState extends DeleteAccountState {}

class DeleteErrorState extends DeleteAccountState {}
