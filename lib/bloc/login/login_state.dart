import '../../model/login/login_model.dart';

abstract class LoginState {}

class InitialState extends LoginState {}

class LoadingState extends LoginState {}

class SuccessState extends LoginState {
  final LoginModel loginModel;

  SuccessState(this.loginModel);
}

class ErrorState extends LoginState {}

class PasswordState extends LoginState {}
