import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/verify_code/verify_code_cubit.dart';
import '../../bloc/verify_code/verify_code_state.dart';
import '../../component/helper.dart';
import '../../component/widget.dart';
import '../../network/local/cache.dart';
import '../all/login.dart';
import 'home_page.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode(this.phoneNumber, {super.key});

 final String phoneNumber;


  @override
  Widget build(BuildContext context) {
    double height = 0;
    return BlocProvider(
      create: (context) => VerifyCodeCubit(),
      child: BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
        listener: (context, state) {
          if (state is CodeSuccessState) {
            if (state.verifyModel.token != null) {
              CacheHelper.saveData(
                  key: 'token', value: state.verifyModel.token);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);
            } else {
              flutterToastt(
                  state.verifyModel.message, "error", height, "gravity");
            }
          }
        },
        builder: (context, state) {
          TextEditingController pinController = TextEditingController();
          return LayoutBuilder(builder: (context, constrain) {
            height = constrain.maxHeight;
            VerifyCodeCubit verifyCodeCubit = VerifyCodeCubit.get(context);
            return AlertDialog(
              actions: [
                Center(
                    child: PinCode(
                  bottom: ConditionalBuilder(
                      condition: state is! CodeLoadingState,
                      builder: (context) => Bottom(
                            text: "ارسال الرمز",
                            onTap: () {
                              if (pinController.text.length < 4) {
                                flutterToastt("من فضلك قم بتعبئة كامل الحقول",
                                    "error", constrain.maxHeight, "pin");
                              } else {
                                if (CacheHelper.getData(key: 'type') ==
                                    "customer") {
                                  verifyCodeCubit.verifyCode(
                                      code: pinController.text,
                                      phone: phoneNumber);
                                } else {
                                  flutterToastt("طلبك قيد المعالجة", "type",
                                      constrain.maxHeight, "notPin");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                }
                              }
                            },
                            height: constrain.maxHeight,
                          ),
                      fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          )),
                  controller: pinController,
                  pinLength: 4,
                  maxHeight: constrain.maxHeight,
                  maxWidth: constrain.maxWidth,
                  phoneNumber: phoneNumber,
                )),
              ],
            );
          });
        },
      ),
    );
  }
}
