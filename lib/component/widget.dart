import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../bloc/cart/view_cart_cubit.dart';
import '../bloc/cart/view_cart_state.dart';
import '../bloc/login/login_cubit.dart';
import '../bloc/login/login_state.dart';
import '../model/cart/cart_model.dart';
import '../theme/colors.dart';
import 'helper.dart';

@immutable
class Filed extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double? height;
  final ValueChanged<String>? onChange;
  final bool? login;
  final GlobalKey<FormFieldState>? formKey;

  const Filed({
    super.key,
    required this.controller,
    required this.hintText,
    this.height,
    required this.login,
    this.onChange,
    this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: textFieldBg),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5),
          child: BlocProvider(
              create: (context) => LoginCubit(),
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return TextFormField(
                    key: formKey,
                    onChanged: onChange,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    controller: controller,
                    validator: (String? value) {
                      if (login != null && login!) {
                        if (hintText == "أدخل رقم الهاتف") {
                          if (value!.isEmpty) {
                            return 'من فضلك أدخل رقم الهاتف';
                          }
                        } else {
                          if (value!.isEmpty) {
                            return "من فضلك أدخل كلمة المرور";
                          }
                        }
                      } else {
                        if (hintText == "أدخل رقم الهاتف") {
                          if (value!.isNotEmpty && value.length != 10) {
                            return 'من فضلك أدخل 10 أرقام فقط';
                          } else if (value.isEmpty) {
                            return 'من فضلك أدخل رقم الهاتف';
                          }
                        } else if (hintText == "أدخل 8 أحرف على الأقل" ||
                            hintText == "أدخل تأكيد كلمة المرور" ||
                            hintText == "أدخل كلمة المرور") {
                          if (value!.isEmpty) {
                            return 'من فضلك أدخل كلمة المرور';
                          } else if (!value.contains(RegExp(r'[a-z]')) ||
                              !value.contains(RegExp(r'[A-Z]'))) {
                            return 'يجب أن يحتوي النص على حرف صغير وحرف كبير على الأقل';
                          } else if (value.isNotEmpty && value.length < 8) {
                            return 'من فضلك أدخل 8 أحرف على الأقل';
                          }
                        } else {
                          if (value!.isEmpty) {
                            return "من فضلك أدخل اسم المستخدم";
                          }
                        }
                      }
                      return null;
                    },
                    style: TextStyle(
                        fontSize: login! ? height! / 46 : height! / 49,
                        fontFamily: "Cairo"),
                    keyboardType: hintText == "أدخل رقم الهاتف"
                        ? TextInputType.number
                        : TextInputType.text,
                    obscureText: hintText == "أدخل كلمة المرور" ||
                            hintText == "أدخل 8 أحرف على الأقل" ||
                            hintText == "أدخل تأكيد كلمة المرور"
                        ? !LoginCubit.get(context).password
                            ? true
                            : false
                        : false,
                    decoration: InputDecoration(
                        hintText: hintText,
                        suffixIcon: hintText == "أدخل رقم الهاتف"
                            ? Icon(
                                Icons.phone_android_outlined,
                                color: primary,
                                size: height! / 26,
                              )
                            : hintText == "أدخل اسم المستخدم"
                                ? Icon(Iconsax.user,
                                    color: primary, size: height! / 26)
                                : Icon(Iconsax.lock,
                                    color: primary, size: height! / 26),
                        prefixIcon: hintText == "أدخل 8 أحرف على الأقل" ||
                                hintText == "أدخل تأكيد كلمة المرور" ||
                                hintText == "أدخل كلمة المرور"
                            ? IconButton(
                                onPressed: () {
                                  LoginCubit.get(context).changeIcons(height!);
                                },
                                icon: LoginCubit.get(context).passwordICon)
                            : null,
                        hintStyle: TextStyle(
                            fontSize: login! ? height! / 46 : height! / 49,
                            fontFamily: "Cairo"),
                        border: InputBorder.none,
                        errorStyle: TextStyle(
                            fontSize: height! / 55, fontFamily: "Cairo")),
                  );
                },
              )),
        ),
      ),
    );
  }
}

@immutable
class Bottom extends StatelessWidget {
  final String text;
  final Function() onTap;
  final double? height;

  const Bottom(
      {super.key, required this.text, this.height, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50),
          child: Container(
            width: double.infinity,
            height: text == "ارسال الرمز" ? height! / 13.5 : height! / 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: primary),
            child: Center(
                child: Text(text,
                    style: TextStyle(
                        fontSize:
                            text == "ارسال الرمز" ? height! / 32 : height! / 42,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: "Cairo"),
                    textAlign: TextAlign.center)),
          ),
        ));
  }
}

@immutable
class PinCode extends StatelessWidget {
  final TextEditingController controller;
  final int pinLength;
  final double maxHeight;
  final double maxWidth;
  final String phoneNumber;
  final Widget bottom;

 const PinCode({
    super.key,
    required this.controller,
    required this.pinLength,
    required this.maxHeight,
    required this.maxWidth,
    required this.phoneNumber,
    required this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'كود التحقق',
          style: TextStyle(
              fontFamily: "Cairo",
              fontSize: maxWidth / 18,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: maxHeight / 40,
        ),
        Text(
          "قمنا بارسال كود التحقق عن طريق رسالة نصيةالى الرقم التالي : $phoneNumber",
          style: TextStyle(
            fontFamily: "Cairo",
            fontSize: maxWidth / 25.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: maxHeight / 40,
        ),
        PinCodeTextField(
          autofocus: true,
          controller: controller,
          highlight: true,
          highlightColor: Colors.blue,
          defaultBorderColor: Colors.black,
          hasTextBorderColor: Colors.white,
          highlightPinBoxColor: Colors.black.withOpacity(1),
          maxLength: pinLength,
          pinBoxWidth: pinLength == 4 ? maxWidth / 6.5 : maxWidth / 8.2,
          pinBoxHeight: maxHeight / 12,
          wrapAlignment: WrapAlignment.spaceAround,
          pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
          pinTextStyle:
              TextStyle(fontSize: maxHeight / 25, color: Colors.white),
          pinTextAnimatedSwitcherTransition:
              ProvidedPinBoxTextAnimation.scalingTransition,
          pinBoxColor: Colors.white,
          pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 300),
          highlightAnimation: true,
          highlightAnimationBeginColor: Colors.green,
          highlightAnimationEndColor: Colors.white12,
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: maxHeight / 35,
        ),
        bottom
      ],
    );
  }
}

class ProductCart extends StatelessWidget {
  final double height, width;
  final CartItems cartItems;
  final BuildContext context1;
  final CartModel cartModel;
  final CartState? state;

  const ProductCart(this.height, this.width, this.cartItems, this.context1,
      this.cartModel, this.state,
      {super.key});

  @override
  Widget build(BuildContext context) {
    var price = double.parse(cartItems.productPrice!);

    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: lightGrey,
        child: Row(textDirection: TextDirection.rtl, children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5),
              child: SizedBox(
                width: width * 0.2,
                height: height * 0.12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(width / 55),
                  child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          EndPoint.imageUrl + cartItems.productPhoto!)),
                ),
              )),
          SizedBox(
            width: width / 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${cartItems.productName}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontFamily: "Cairo", fontSize: width / 25),
              ),
              SizedBox(
                height: height / 60,
              ),
              Text(
                "${price * cartItems.quantity!} ل.س ",
                style: TextStyle(fontSize: width / 28, color: green),
                textDirection: TextDirection.rtl,
              )
            ],
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(top: width * 0.015 + height * 0.015),
            child: Row(
              children: [
                ConditionalBuilder(
                    condition: state is! DeleteProductLoadingState,
                    builder: (context) => IconButton(
                          onPressed: () {
                            CartCubit.get(context1)
                                .deleteProductFromCart(id: cartItems.productId);
                            CartCubit.get(context1).updatePrice(cartModel);
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            size: width * 0.022 + height * 0.022,
                            color: green,
                          ),
                        ),
                    fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        )),
                ZoomTapAnimation(
                  onTap: () {
                    CartCubit.get(context1)
                        .changeQuantity("add", cartItems, cartModel);
                    CartCubit.get(context).updateProductQuantityInCart(
                        id: cartItems.productId, quantity: cartItems.quantity);
                  },
                  child: Container(
                      height: height / 22,
                      width: width / 17,
                      decoration: BoxDecoration(
                          color: green, borderRadius: BorderRadius.circular(3)),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: width / 19,
                      )),
                ),
                SizedBox(
                  width: width / 100,
                ),
                Text(
                  "${cartItems.quantity}",
                  style: TextStyle(fontSize: width / 23),
                ),
                SizedBox(
                  width: width / 100,
                ),
                ZoomTapAnimation(
                  onTap: () {
                    CartCubit.get(context1)
                        .changeQuantity("minus", cartItems, cartModel);
                    CartCubit.get(context).updateProductQuantityInCart(
                        id: cartItems.productId, quantity: cartItems.quantity);
                  },
                  child: Container(
                      height: height / 22,
                      width: width / 17,
                      decoration: BoxDecoration(
                          color: green, borderRadius: BorderRadius.circular(3)),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: width / 19,
                      )),
                ),
              ],
            ),
          )
        ]));
  }
}
