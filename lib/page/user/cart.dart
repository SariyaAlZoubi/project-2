import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../bloc/cart/view_cart_cubit.dart';
import '../../bloc/cart/view_cart_state.dart';
import '../../component/confirmCartWithDifferentLocation.dart';
import '../../component/confirmCartWithSameLocation.dart';
import '../../component/helper.dart';
import '../../component/widget.dart';
import '../../model/cart/cart_model.dart';
import '../../network/local/cache.dart';
import '../../theme/colors.dart';

class Cart extends StatelessWidget {
 const Cart({super.key, this.message});

 final String? message;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
        create: (context) => CartCubit()..getCart(),
        child: BlocConsumer<CartCubit, CartState>(builder: (context, state) {
          return ConditionalBuilder(
              condition: CartCubit.get(context).cartModel != null,
              builder: (context) => CartCubit.get(context).cartModel!.message !=
                      null
                  ? Scaffold(
                      appBar: AppBar(
                        backgroundColor: green,
                        centerTitle: true,
                        title: const Text('سلة التسوق'),
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: "Cairo",
                            fontSize: width * 0.012 + height * 0.02,
                            color: Colors.white),
                      ),
                      body: Center(
                        child: Text(
                          "سلة التسوق فارغة",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: "Cairo",
                            fontSize: width * 0.01 + height * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  : Scaffold(
                      bottomNavigationBar: getBottom(width, height, context,
                          CartCubit.get(context).cartModel!),
                      appBar: AppBar(
                        iconTheme: IconThemeData(
                            color: Colors.white, size: width / 15),
                        backgroundColor: green,
                        elevation: 0,
                        title: const Text("سلة التسوق"),
                        actions: [
                          ConditionalBuilder(
                              condition: state is! ClearCartLoadingState,
                              builder: (context) => IconButton(
                                  onPressed: () {
                                    CartCubit.get(context).clearCart();
                                  },
                                  icon: const Icon(Icons.delete_outline)),
                              fallback: (context) => const Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  ))
                        ],
                        centerTitle: true,
                        titleTextStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: "Cairo",
                            fontSize: width * 0.012 + height * 0.02,
                            color: Colors.white),
                      ),
                      body: CartCubit.get(context)
                              .cartModel!
                              .cartItems!
                              .isNotEmpty
                          ? LayoutBuilder(
                              builder: (context2, constrain) => Padding(
                                  padding: EdgeInsets.only(top: height / 100),
                                  child: ListView.separated(
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context1, index) =>
                                          ProductCart(
                                              constrain.maxHeight,
                                              constrain.maxWidth,
                                              CartCubit.get(context)
                                                  .cartModel!
                                                  .cartItems![index],
                                              context,
                                              CartCubit.get(context).cartModel!,
                                              state),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: constrain.maxHeight / 40,
                                          ),
                                      itemCount: CartCubit.get(context)
                                          .cartModel!
                                          .cartItems!
                                          .length)))
                          : Center(
                              child: Text(
                                "سلة التسوق فارغة",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Cairo",
                                    fontSize: width * 0.01 + height * 0.02,
                                    color: Colors.black),
                              ),
                            )),
              fallback: (context) => const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(green),
                      ),
                    ),
                  ));
        }, listener: (context, state) {
          if (state is ConfirmCartSuccessState) {
            flutterToastt(state.message, "type", height, "gravity");
          }
        }));
  }

  Widget getBottom(width, height, BuildContext context, CartModel cartModel) {
    return Container(
      height: height > 1000
          ? height * 0.11 + width * 0.08
          : height * 0.098 + width * 0.079,
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 2, color: Colors.white))),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            cartModel.cartItems!.isEmpty
                ? Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        ' : قيمة التوصيل',
                        style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: height * 0.016 + width * 0.016),
                      ),
                      Text(
                        "0",
                        style: TextStyle(
                            color: green,
                            fontSize: height * 0.011 + width * 0.02,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                : Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        ' : قيمة التوصيل',
                        style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: height * 0.016 + width * 0.016),
                      ),
                      Text(
                        "${cartModel.deliveryValue}",
                        style: TextStyle(
                            color: green,
                            fontSize: height * 0.011 + width * 0.02,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
            Row(
              textDirection: TextDirection.rtl,
              children: [
                CacheHelper.getData(key: 'bool') == false
                    ? const ConfirmCartWithDifferentLocation('bool')
                    : ZoomTapAnimation(
                        onTap: cartModel.cartItems!.isEmpty
                            ? null
                            : () {
                                showDialog(
                                    context: context,
                                    builder: (context2) => AlertDialog(
                                          actions: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'هل تريد البقاء على نفس الموقع ؟',
                                                  style: TextStyle(
                                                      fontFamily: "Cairo",
                                                      fontSize: height * 0.014 +
                                                          width * 0.014),
                                                ),
                                                SizedBox(
                                                  height: height / 35,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const ConfirmCartWithSameLocation(),
                                                    SizedBox(
                                                      width: width / 10,
                                                    ),
                                                    const ConfirmCartWithDifferentLocation(
                                                        'type')
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ));
                              },
                        child: Container(
                          height: width >= 600 ? height / 15 : height / 19,
                          width: width / 2,
                          decoration: BoxDecoration(
                              color: green,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            "تأكيد الطلب",
                            style: TextStyle(
                                fontSize: width / 20,
                                fontFamily: "Cairo",
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' اجمالي الفاتورة:',
                      style:
                          TextStyle(fontFamily: "Cairo", fontSize: width / 25),
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(
                      height: height / 100,
                    ),
                    cartModel.cartItems!.isEmpty
                        ? Text(
                            '0',
                            style: TextStyle(
                                color: green,
                                fontSize: width / 27,
                                fontWeight: FontWeight.w900),
                            textDirection: TextDirection.rtl,
                          )
                        : Text(
                            '${cartModel.total} ل.س ',
                            style: TextStyle(
                                color: green,
                                fontSize: width / 27,
                                fontWeight: FontWeight.w900),
                            textDirection: TextDirection.rtl,
                          )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
