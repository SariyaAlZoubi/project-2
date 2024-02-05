import '../../model/register/register_model.dart';

abstract class RegisterState {}

class InitState extends RegisterState {}

class LoadingState extends RegisterState {}

class SuccessState extends RegisterState {
  final RegisterModel registerModel;

  SuccessState(this.registerModel);
}

class ErrorState extends RegisterState {}

class RemoveField extends RegisterState {}
