import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/rating_product/rating_product_state.dart';
import '../../network/remote/http.dart';

class RatingProductCubit extends Cubit<RatingProductState> {
  RatingProductCubit() : super(InitialState());

  static RatingProductCubit get(context) => BlocProvider.of(context);

  double rating = 0;

  Future ratingProduct({required id}) async {
    emit(LoadingState());
    await HttpHelper.postData(url: 'addProductEvaluation/$id/$rating', data: {})
        .then((value) {
      emit(SuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(ErrorState());
    });
  }
}
