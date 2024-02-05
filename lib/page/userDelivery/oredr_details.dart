import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../bloc/orders/order_details_cubit.dart';
import '../../bloc/orders/order_details_state.dart';
import '../../bloc/orders/orders_cubit.dart';
import '../../component/helper.dart';
import '../../model/orders/order_details.dart';
import '../../network/local/cache.dart';
import '../../theme/colors.dart';
import '../delivery/map.dart';

class OrderDetails extends StatelessWidget {


 const OrderDetails(this.type, this.ordersCubit, this.id, {super.key});

 final OrdersCubit? ordersCubit;
 final String? type;
 final int id;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (context) => OrderDetailsCubit()..getDetailsOrder(id: id),
        child: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
          listener: (context, state) {
            if (state is StartDeliverySuccessState) {
              flutterToastt("شكرا لك على قبول الطلب قم بتوصيله من فضلك",
                  "error", height, "gravity");
            }
          },
          builder: (context, state) {
            OrderDetailsCubit orderDetailsCubit =
                OrderDetailsCubit.get(context);
            return Scaffold(
                floatingActionButton:
                    CacheHelper.getData(key: 'type') == "delivery"
                        ? FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: green,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Map(
                                              orderDetailsCubit
                                                  .orderDetailsModel!
                                                  .orderDetail!
                                                  .orderId!)));
                                },
                                icon: const Icon(
                                  Icons.map_outlined,
                                )))
                        : const SizedBox(),
                bottomNavigationBar: OrderDetailsCubit.get(context)
                            .orderDetailsModel !=
                        null
                    ? (CacheHelper.getData(key: 'type') == "customer"
                        ? getBottom(height, width,
                            OrderDetailsCubit.get(context).orderDetailsModel!)
                        : Container(
                            height: height > 1000
                                ? height * 0.11 + width * 0.08
                                : height * 0.072 + width * 0.053,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        width: 2, color: Colors.white))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                textDirection: TextDirection.rtl,
                                children: [
                                  Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      ConditionalBuilder(
                                          condition: state
                                              is! StartDeliveryLoadingState,
                                          builder: (context) =>
                                              ZoomTapAnimation(
                                                  onTap: type == 'order'
                                                      ? null
                                                      : () {
                                                          orderDetailsCubit
                                                              .startDelivery(
                                                                  id: id);
                                                          ordersCubit!
                                                              .deleteOrder(
                                                                  id: id);
                                                        },
                                                  child: Container(
                                                    height: width >= 600
                                                        ? height / 15
                                                        : height / 19,
                                                    width: width / 2,
                                                    decoration: BoxDecoration(
                                                        color: green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: Text(
                                                      "قبول الطلب",
                                                      style: TextStyle(
                                                          fontSize: width / 20,
                                                          fontFamily: "Cairo",
                                                          color: Colors.white),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )),
                                          fallback: (context) => const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(green),
                                                ),
                                              )),
                                      const Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            ' اجمالي الفاتورة:',
                                            style: TextStyle(
                                                fontFamily: "Cairo",
                                                fontSize: width / 25),
                                            textDirection: TextDirection.rtl,
                                          ),
                                          SizedBox(
                                            height: height / 100,
                                          ),
                                          Text(
                                            '${orderDetailsCubit.orderDetailsModel!.orderDetail!.total} ل.س ',
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
                          ))
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('تفاصيل الطلب'),
                  titleTextStyle:
                      TextStyle(fontFamily: "Cairo", fontSize: height * 0.023),
                  backgroundColor: green,
                ),
                body: OrderDetailsCubit.get(context).orderDetailsModel != null
                    ? Padding(
                        padding: EdgeInsets.only(top: height * 0.023),
                        child: ListView.separated(
                            itemBuilder: (context, index) => Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: Colors.white.withOpacity(0.85),
                                child: Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7.0, vertical: 5),
                                          child: SizedBox(
                                            width: width * 0.2,
                                            height: height * 0.09,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width / 55),
                                              child: Image(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(EndPoint
                                                          .imageUrl +
                                                      OrderDetailsCubit.get(
                                                              context)
                                                          .orderDetailsModel!
                                                          .orderDetail!
                                                          .orderItems![index]
                                                          .image!)),
                                            ),
                                          )),
                                      SizedBox(
                                        width: width / 40,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${OrderDetailsCubit.get(context).orderDetailsModel!.orderDetail!.orderItems![index].productName}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: "Cairo",
                                                fontSize: width / 25),
                                          ),
                                          SizedBox(
                                            height:
                                                height * 0.001 + width * 0.012,
                                          ),
                                          Text(
                                            " ${OrderDetailsCubit.get(context).orderDetailsModel!.orderDetail!.orderItems![index].itemPrice} ل.س ",
                                            style: TextStyle(
                                                fontSize: width / 28,
                                                fontWeight: FontWeight.w700,
                                                color: green),
                                            textDirection: TextDirection.rtl,
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      CacheHelper.getData(key: 'type') ==
                                              "customer"
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  left: height * 0.01 +
                                                      width * 0.01),
                                              child: Checkbox(
                                                activeColor: green,
                                                value: true,
                                                onChanged: (bool? value) {},
                                                checkColor: Colors.white,
                                              ),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  left: height * 0.01 +
                                                      width * 0.01),
                                              child: Column(
                                                textDirection:
                                                    TextDirection.rtl,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    children: [
                                                      Text(
                                                        ' : المحل',
                                                        style: TextStyle(
                                                            fontFamily: "Cairo",
                                                            fontSize: height *
                                                                    0.013 +
                                                                width * 0.01),
                                                      ),
                                                      Text(
                                                          OrderDetailsCubit.get(
                                                                  context)
                                                              .orderDetailsModel!
                                                              .orderDetail!
                                                              .orderItems![
                                                                  index]
                                                              .shopName!,
                                                          style: TextStyle(
                                                            fontFamily: "Cairo",
                                                            fontSize: height *
                                                                    0.013 +
                                                                width * 0.01,
                                                            color: green,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.01,
                                                  ),
                                                  Row(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    children: [
                                                      Text(
                                                        ' : الكمية',
                                                        style: TextStyle(
                                                            fontFamily: "Cairo",
                                                            fontSize: height *
                                                                    0.013 +
                                                                width * 0.01),
                                                      ),
                                                      Text(
                                                          "${OrderDetailsCubit.get(context).orderDetailsModel!.orderDetail!.orderItems![index].quantity!}",
                                                          style: TextStyle(
                                                            fontFamily: "Cairo",
                                                            fontSize: height *
                                                                    0.013 +
                                                                width * 0.01,
                                                            color: green,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                    ])),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: height * 0.02,
                                ),
                            itemCount: OrderDetailsCubit.get(context)
                                .orderDetailsModel!
                                .orderDetail!
                                .orderItems!
                                .length),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ));
          },
        ));
  }

  Widget getBottom(
      double height, double width, OrderDetailsModel orderDetailsModel) {
    String status = "";
    if (orderDetailsModel.orderDetail!.orderState == "processing" ||
        orderDetailsModel.orderDetail!.orderState == "approved") {
      status = "قيد المعالجة";
    } else if (orderDetailsModel.orderDetail!.orderState == "delivered") {
      status = "تم التسليم";
    } else if (orderDetailsModel.orderDetail!.orderState == "delivery") {
      status = "جاري التوصيل";
    } else if (orderDetailsModel.orderDetail!.orderState == "rejected") {
      status = "تم الرفض";
    }
    return Container(
      height: height > 1000
          ? height * 0.03 + width * 0.02
          : height * 0.09 + width * 0.01,
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 2, color: Colors.white))),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(
                  ': السعر النهائي',
                  style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: height * 0.014 + width * 0.01),
                ),
                Text(
                  "${orderDetailsModel.orderDetail!.total} ",
                  style: TextStyle(
                      fontSize: height * 0.013 + width * 0.01,
                      fontFamily: "Cairo",
                      color: green),
                ),
                Text('ل.س ',
                    style: TextStyle(
                        fontSize: height * 0.013 + width * 0.01,
                        fontFamily: "Cairo",
                        color: green)),
                const Spacer(),
                Text(
                  status,
                  style: TextStyle(
                      color: green,
                      fontFamily: "Cairo",
                      fontSize: height * 0.014 + width * 0.01),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
