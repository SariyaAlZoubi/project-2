import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/page/all/register.dart';
import '../../bloc/login/login_cubit.dart';
import '../../bloc/login/login_state.dart';
import '../../component/helper.dart';
import '../../component/widget.dart';
import '../../network/local/cache.dart';
import '../../theme/colors.dart';
import '../user/home_page.dart';
import '../userDelivery/orders.dart';
import '../vendor/get_vendor_shop.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: heightScreen / 45,
            right: heightScreen / 45,
            top: heightScreen / 16),
        child: LayoutBuilder(builder: (context, constrain) {
          double fontSize = constrain.maxHeight / 50;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Form(
                key: formKey,
                child: BlocProvider(
                  create: (context) => LoginCubit()..getDeviceToken(),
                  child: BlocConsumer<LoginCubit, LoginState>(
                      builder: (context, state) {
                    onTap() {
                      if (formKey.currentState!.validate()) {
                        LoginCubit.get(context).login(
                            phoneNumber: phoneNumber.text,
                            password: password.text);
                      }
                    }

                    return Column(
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                            child: SizedBox(
                          height: constrain.maxHeight / 2.75,
                          width: constrain.maxWidth / 1.2,
                          child: getSvgIcon("welcome3.svg"),
                        )),
                        SizedBox(
                          height: constrain.maxHeight / 20,
                        ),
                        Text(
                          "رقم الهاتف",
                          style: TextStyle(
                              fontSize: fontSize,
                              color: grey,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Cairo"),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          height: constrain.maxHeight / 70,
                        ),
                        Filed(
                            controller: phoneNumber,
                            hintText: "أدخل رقم الهاتف",
                            height: constrain.maxHeight,
                            login: true),
                        SizedBox(
                          height: constrain.maxHeight / 35,
                        ),
                        Text(
                          "كلمة المرور",
                          style: TextStyle(
                              fontSize: fontSize,
                              color: grey,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Cairo"),
                        ),
                        SizedBox(
                          height: heightScreen / 70,
                        ),
                        Filed(
                            controller: password,
                            hintText: "أدخل كلمة المرور",
                            height: constrain.maxHeight,
                            login: true),
                        SizedBox(
                          height: constrain.maxHeight / 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoadingState,
                          builder: (context) => Bottom(
                            text: "تسجيل الدخول",
                            height: constrain.maxHeight,
                            onTap: onTap,
                          ),
                          fallback: (context) => const Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(primary),
                          )),
                        ),
                        SizedBox(
                          height: constrain.maxHeight / 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              "ليس لديك حساب بعد؟",
                              style: TextStyle(
                                  fontSize: fontSize,
                                  decoration: TextDecoration.underline,
                                  fontFamily: "Cairo"),
                              textAlign: TextAlign.right,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()));
                                },
                                child: Text(
                                  " أنشئ حساب",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSize,
                                      color: primary,
                                      fontFamily: "Cairo"),
                                  textAlign: TextAlign.right,
                                ))
                          ],
                        )
                      ],
                    );
                  }, listener: (context, state) {
                    if (state is SuccessState) {
                      if (state.loginModel.status == true) {
                        CacheHelper.saveData(
                            key: "token", value: state.loginModel.token);
                        CacheHelper.saveData(
                            key: "type", value: state.loginModel.type);
                        if (state.loginModel.type == 'vendor') {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const GetVendorShop()),
                              (route) => false);
                        } else if (state.loginModel.type == 'delivery') {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Orders('orders')),
                              (route) => false);
                        } else if (state.loginModel.type == 'customer') {
                          CacheHelper.saveData(
                              key: 'id', value: state.loginModel.data!.id);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (route) => false);
                        }
                      } else {
                        flutterToast(
                            state.loginModel.message.toString(), "error");
                      }
                    }
                  }),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
