import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/orders/order_details.dart';
import '../../network/remote/http.dart';
import 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(InitialState());

  static OrderDetailsCubit get(context) => BlocProvider.of(context);

  OrderDetailsModel? orderDetailsModel;

  Future getDetailsOrder({required id}) async {
    emit(LoadingState());
    await HttpHelper.getData(url: "viewOrderDetailssssssssssss/$id")
        .then((value) {
      if (value.statusCode == 200) {
        orderDetailsModel = OrderDetailsModel.fromJson(jsonDecode(value.body));
        orderDetailsModel!.orderDetail!.total =
            orderDetailsModel!.orderDetail!.total! - 5000;
        emit(SuccessState());
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(ErrorState());
    });
  }

  Future startDelivery({required id}) async {
    emit(StartDeliveryLoadingState());
    await HttpHelper.putData(url: "startDelivery", data: {'order_id': "$id"})
        .then((value) {
      var response = jsonDecode(value.body);
      String message;
      message = response['message'];
      emit(StartDeliverySuccessState(message));
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(StartDeliveryErrorState());
    });
  }
}
