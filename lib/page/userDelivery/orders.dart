import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../bloc/account/delete/delete_cubit.dart';
import '../../bloc/account/delete/delete_state.dart';
import '../../bloc/account/logout/logout_cubit.dart';
import '../../bloc/account/logout/logout_state.dart';
import '../../bloc/orders/orders_cubit.dart';
import '../../bloc/orders/orders_state.dart';
import '../../component/helper.dart';
import '../../model/orders/orders.dart';
import '../../network/local/cache.dart';
import '../../theme/colors.dart';
import '../all/login.dart';
import 'oredr_details.dart';

class Orders extends StatelessWidget {
  const Orders(this.type, {super.key});

  final String type;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
        create: (context) {
          if (type == "orders") {
            return OrdersCubit()..getHistoryOrders();
          } else {
            return OrdersCubit()..getApprovedOrders();
          }
        },
        child: BlocConsumer<OrdersCubit, OrdersState>(
          listener: (context, state) {},
          builder: (context, state) {
            OrdersCubit ordersCubit = OrdersCubit.get(context);
            return Scaffold(
              drawer: CacheHelper.getData(key: 'type') == 'delivery'
                  ? Directionality(
                      textDirection: TextDirection.rtl,
                      child: Drawer(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: <Widget>[
                            DrawerHeader(
                              decoration: const BoxDecoration(
                                color: primary,
                              ),
                              child: SizedBox(
                                height: height * 0.3,
                                width: width * 0.2,
                                child: getSvgIcon('welcome3.svg'),
                              ),
                            ),
                            BlocProvider(
                                create: (context) => LogOutCubit(),
                                child: BlocConsumer<LogOutCubit, LogOutState>(
                                  listener: (context, state) {
                                    if (state is LogOutSuccessState) {
                                      CacheHelper.removeData(key: 'token');
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                          (route) => false);
                                    }
                                  },
                                  builder: (context, state) {
                                    return ConditionalBuilder(
                                        condition: state is! LogOutLoadingState,
                                        builder: (context) => ListTile(
                                              leading: Icon(
                                                Icons.logout_outlined,
                                                color: green,
                                                size: height * 0.022 +
                                                    width * 0.015,
                                              ),
                                              title: Text(
                                                'تسجيل الخروج',
                                                style: TextStyle(
                                                    fontFamily: "Cairo",
                                                    fontSize: height * 0.015 +
                                                        width * 0.01,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              onTap: () {
                                                LogOutCubit.get(context)
                                                    .logout();
                                              },
                                            ),
                                        fallback: (context) => const Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(green),
                                              ),
                                            ));
                                  },
                                )),
                            BlocProvider(
                                create: (context) => DeleteAccountCubit(),
                                child: BlocConsumer<DeleteAccountCubit,
                                    DeleteAccountState>(
                                  listener: (context, state) {
                                    if (state is DeleteSuccessState) {
                                      CacheHelper.removeData(key: 'token');
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                          (route) => false);
                                    }
                                  },
                                  builder: (context, state) {
                                    return ConditionalBuilder(
                                        condition: state is! DeleteLoadingState,
                                        builder: (context) => ListTile(
                                              leading: Icon(
                                                Icons.delete_outline_outlined,
                                                color: green,
                                                size: height * 0.022 +
                                                    width * 0.015,
                                              ),
                                              title: Text(
                                                'حذف الحساب',
                                                style: TextStyle(
                                                    fontFamily: "Cairo",
                                                    fontSize: height * 0.015 +
                                                        width * 0.01,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              onTap: () {
                                                DeleteAccountCubit.get(context)
                                                    .deleteAccount();
                                              },
                                            ),
                                        fallback: (context) => const Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(green),
                                              ),
                                            ));
                                  },
                                )),
                            // إضافة قائمة العناصر الأخرى هنا
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
              appBar: AppBar(
                centerTitle: true,
                title: type == 'orders'
                    ? const Text('الطلبات')
                    : const Text('الطلبات المقبولة'),
                titleTextStyle:
                    TextStyle(fontFamily: "Cairo", fontSize: height * 0.023),
                backgroundColor: green,
                actions: [
                  type == 'orders' &&
                          CacheHelper.getData(key: 'type') == 'delivery'
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Orders('order')));
                          },
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                          ))
                      : const SizedBox()
                ],
              ),
              body: type == 'orders' &&
                      CacheHelper.getData(key: 'type') == 'delivery'
                  ? RefreshIndicator(
                      color: Colors.white,
                      backgroundColor: green,
                      onRefresh: () async {
                        await context.read<OrdersCubit>().getHistoryOrders();
                        await Future.delayed(const Duration(seconds: 2));
                      },
                      child: LayoutBuilder(
                        builder: (context, constrain) => OrdersCubit.get(
                                        context)
                                    .ordersModel !=
                                null
                            ? (OrdersCubit.get(context)
                                    .ordersModel!
                                    .ordersInfo!
                                    .isNotEmpty
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.023),
                                    child: ListView.separated(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemBuilder: (context, index) => item(
                                            ordersCubit,
                                            constrain.maxHeight,
                                            constrain.maxWidth,
                                            OrdersCubit.get(context)
                                                .ordersModel!
                                                .ordersInfo![index],
                                            context),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              height: constrain.maxWidth *
                                                      0.01 +
                                                  constrain.maxHeight * 0.02,
                                            ),
                                        itemCount: OrdersCubit.get(context)
                                            .ordersModel!
                                            .ordersInfo!
                                            .length),
                                  )
                                : Center(
                                    child: Text(
                                      "لا يوجد طلبات",
                                      style: TextStyle(
                                          fontFamily: "Cairo",
                                          fontSize:
                                              height * 0.02 + width * 0.02,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ))
                            : const Center(
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(green),
                                ),
                              ),
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, constrain) => OrdersCubit.get(context)
                                  .ordersModel !=
                              null
                          ? (OrdersCubit.get(context)
                                  .ordersModel!
                                  .ordersInfo!
                                  .isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(top: height * 0.023),
                                  child: ListView.separated(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemBuilder: (context, index) => item(
                                          ordersCubit,
                                          constrain.maxHeight,
                                          constrain.maxWidth,
                                          OrdersCubit.get(context)
                                              .ordersModel!
                                              .ordersInfo![index],
                                          context),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: constrain.maxWidth * 0.01 +
                                                constrain.maxHeight * 0.02,
                                          ),
                                      itemCount: OrdersCubit.get(context)
                                          .ordersModel!
                                          .ordersInfo!
                                          .length),
                                )
                              : Center(
                                  child: Text(
                                    "لا يوجد طلبات",
                                    style: TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize: height * 0.02 + width * 0.02,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ))
                          : const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(green),
                              ),
                            ),
                    ),
            );
          },
        ));
  }

  Widget item(OrdersCubit ordersCubit, double height, double width,
      OrdersInfo ordersInfo, BuildContext context) {
    String status = "";
    if (ordersInfo.orderState == "processing" ||
        ordersInfo.orderState == "approved") {
      status = "قيد المعالجة";
    } else if (ordersInfo.orderState == "delivered") {
      status = "تم التسليم";
    } else if (ordersInfo.orderState == "delivery") {
      status = "جاري التوصيل";
    } else if (ordersInfo.orderState == "rejected") {
      status = "تم الرفض";
    }
    return Padding(
      padding: EdgeInsets.only(
          left: width * 0.01 + height * 0.02,
          right: width * 0.01 + height * 0.02),
      child: ZoomTapAnimation(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OrderDetails(type, ordersCubit, ordersInfo.id!)));
          },
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.white.withOpacity(0.85),
            child: Column(
              textDirection: TextDirection.rtl,
              children: [
                SizedBox(
                    height: height * 0.145 + width * 0.12,
                    width: double.infinity,
                    child: Image(
                      image:
                          NetworkImage(EndPoint.imageUrl + ordersInfo.image!),
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: height * 0.01, bottom: height * 0.01),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      CacheHelper.getData(key: 'type') == "customer"
                          ? Text(
                              ' : الحالة',
                              style: TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: height * 0.015 + width * 0.015),
                            )
                          : Text(
                              ' :الإسم',
                              style: TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: height * 0.015 + width * 0.015),
                            ),
                      CacheHelper.getData(key: 'type') == "customer"
                          ? Text(
                              status,
                              style: TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: height * 0.014 + width * 0.014,
                                  color: green,
                                  fontWeight: FontWeight.w700),
                            )
                          : Text(
                              '${ordersInfo.customerName} ',
                              style: TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: height * 0.014 + width * 0.014,
                                  color: green,
                                  fontWeight: FontWeight.w700),
                            ),
                      const Spacer(),
                      CacheHelper.getData(key: 'type') == "delivery"
                          ? Padding(
                              padding: EdgeInsets.only(left: height * 0.01),
                              child: Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Text(
                                    ' : الرقم',
                                    style: TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize:
                                            height * 0.015 + width * 0.015),
                                  ),
                                  Text(
                                    ordersInfo.customerNumber!,
                                    style: TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize:
                                            height * 0.014 + width * 0.014,
                                        color: green,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
