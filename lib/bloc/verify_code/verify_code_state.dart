import 'package:untitled1/model/verify_code/verify_model.dart';

abstract class VerifyCodeState {}

class InitState extends VerifyCodeState {}

class CodeLoadingState extends VerifyCodeState {}

class CodeSuccessState extends VerifyCodeState {
  VerifyModel verifyModel;

  CodeSuccessState(this.verifyModel);
}

class CodeErrorState extends VerifyCodeState {}
