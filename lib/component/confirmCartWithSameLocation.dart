


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../bloc/cart/confirm_cart_with_same_location_cubit.dart';
import '../bloc/cart/confirm_cart_with_same_location_state.dart';
import '../theme/colors.dart';
import 'helper.dart';

class ConfirmCartWithSameLocation extends StatelessWidget {
  const ConfirmCartWithSameLocation({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
        create: (context) => ConfirmCartWithSameLocationCubit(),
        child: BlocConsumer<ConfirmCartWithSameLocationCubit,
            ConfirmCartWithSameLocationState>(
          listener: (context, state) {
            if (state is SuccessState) {
              flutterToastt(state.message, "type", height, "gravity");
            }
          },
          builder: (context, state) {
            ConfirmCartWithSameLocationCubit confirm =
                ConfirmCartWithSameLocationCubit.get(context);
            return ConditionalBuilder(
                condition: state is! LoadingState,
                builder: (context) => ZoomTapAnimation(
                    onTap: () {
                      confirm.confirmCart();
                    },
                    child: Container(
                      width: width * 0.12,
                      height: height / 20,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(width * 0.01 + height * 0.01),
                        color: green,
                      ),
                      child: const Center(
                          child: Text(
                        'نعم',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Cairo",
                        ),
                      )),
                    )),
                fallback: (context) => const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(green)),
                      ),
                    ));
          },
        ));
  }
}
