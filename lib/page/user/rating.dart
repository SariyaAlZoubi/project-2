import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../bloc/rating_product/rating_product_cubit.dart';
import '../../bloc/rating_product/rating_product_state.dart';
import '../../component/helper.dart';
import '../../theme/colors.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen(this.id, {super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RatingProductCubit(),
        child: BlocConsumer<RatingProductCubit, RatingProductState>(
          listener: (context, state) {
            if (state is SuccessState) {
              flutterToastt('تم تقييم المنتج بنجاح', "error", 1000, 'd');
            }
          },
          builder: (context, state) {
            RatingProductCubit ratingProductCubit =
                RatingProductCubit.get(context);
            return LayoutBuilder(
                builder: (context, constrain) => AlertDialog(
                      actions: [
                        Center(
                          child: RatingBar.builder(
                            initialRating: ratingProductCubit.rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 40,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              ratingProductCubit.rating = rating;
                            },
                          ),
                        ),
                        SizedBox(height: constrain.maxHeight * 0.02),
                        Center(
                            child: ConditionalBuilder(
                                condition: state is! LoadingState,
                                builder: (context) => ZoomTapAnimation(
                                      onTap: () {
                                        ratingProductCubit.ratingProduct(
                                            id: id);
                                      },
                                      child: Container(
                                        width: constrain.maxWidth / 2.5,
                                        decoration: BoxDecoration(
                                            color: green,
                                            borderRadius: BorderRadius.circular(
                                                constrain.maxWidth * 0.01 +
                                                    constrain.maxHeight *
                                                        0.01)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'قدّم التقييم',
                                              style: TextStyle(
                                                  fontSize:
                                                      constrain.maxHeight *
                                                              0.014 +
                                                          constrain.maxWidth *
                                                              0.013,
                                                  color: Colors.white,
                                                  fontFamily: "Cairo"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                fallback: (context) => const Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                green),
                                      ),
                                    ))),
                      ],
                    ));
          },
        ));
  }
}
