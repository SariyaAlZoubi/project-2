
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../bloc/cart/confirm_cart_with_different_location_state.dart';
import '../bloc/cart/confirm_cart_with_diffrent_location_cubit.dart';
import '../bloc/location/add_location_cubit.dart';
import '../bloc/location/add_location_state.dart';
import '../network/local/cache.dart';
import '../theme/colors.dart';
import 'helper.dart';

class ConfirmCartWithDifferentLocation extends StatelessWidget {
  const ConfirmCartWithDifferentLocation(this.type, {super.key});

  final String type;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
        create: (context) => ConfirmCartWithDifferentLocationCubit(),
        child: BlocConsumer<ConfirmCartWithDifferentLocationCubit,
            ConfirmCartWithDifferentLocationState>(
          listener: (context, state) {
            if (state is SuccessState) {
              flutterToastt(state.message, "type", height, "gravity");
            }
          },
          builder: (context, state) {
            ConfirmCartWithDifferentLocationCubit confirm =
                ConfirmCartWithDifferentLocationCubit.get(context);
            return BlocProvider(
                create: (context) => AddLocationCubit(),
                child: BlocConsumer<AddLocationCubit, AddLocationState>(
                  listener: (context, state) {
                    if (state is GetLocationSuccessState) {
                      AddLocationCubit.get(context).addLocation();
                    }
                    if (state is AddLocationSuccessState) {
                      confirm.confirmCart();
                    }
                  },
                  builder: (context, state) {
                    AddLocationCubit addLocationCubit =
                        AddLocationCubit.get(context);
                    return ConditionalBuilder(
                        condition: state is! GetLocationLoadingState,
                        builder: (context) => ZoomTapAnimation(
                              onTap: () {
                                CacheHelper.saveData(key: 'bool', value: true);

                                addLocationCubit.getLocation();
                              },
                              child: type == 'bool'
                                  ? Container(
                                      height: width >= 600
                                          ? height / 15
                                          : height / 19,
                                      width: width / 2,
                                      decoration: BoxDecoration(
                                          color: green,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text(
                                        "تأكيد الطلب",
                                        style: TextStyle(
                                            fontSize: width / 20,
                                            fontFamily: "Cairo",
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : Container(
                                      width: width * 0.12,
                                      height: height / 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            width * 0.01 + height * 0.01),
                                        color: green,
                                      ),
                                      child: const Center(
                                          child: Text(
                                        'لا',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Cairo",
                                        ),
                                      )),
                                    ),
                            ),
                        fallback: (context) => const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(green),
                              ),
                            ));
                  },
                ));
          },
        ));
  }
}
