import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/account/delete/delete_cubit.dart';
import '../../bloc/account/delete/delete_state.dart';
import '../../bloc/account/logout/logout_cubit.dart';
import '../../bloc/account/logout/logout_state.dart';
import '../../bloc/get_store/get_store_cubit.dart';
import '../../bloc/get_store/get_store_state.dart';
import '../../component/helper.dart';
import '../../model/store/get_vendor_shop.dart';
import '../../network/local/cache.dart';
import '../../theme/colors.dart';
import '../all/login.dart';
import '../user/store_product.dart';
import 'add_store.dart';

class GetVendorShop extends StatelessWidget {
  const GetVendorShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;

        return BlocProvider(
          create: (context) => GetStoreCubit()..getVendorShop(),
          child: BlocConsumer<GetStoreCubit, GetStoreState>(
            listener: (context, state) {},
            builder: (context, state) {
              const Color green = Color(0xFF169956);
              GetVendorShopModel? getVendorShopModel =
                  GetStoreCubit.get(context).getVendorShopModel;

              return getVendorShopModel != null
                  ? Scaffold(
                floatingActionButton: Transform.translate(
                  offset:const Offset(10, 5),
                  child: SizedBox(
                    height: height*0.1,
                    width: width*0.15,
                    child: FittedBox(
                      child: FloatingActionButton(

                        backgroundColor: secondaryColor,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>  AddStore()));
                        },
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ),
                ),
                      drawer: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Drawer(
                          width: width/1.5,
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
                                          condition:
                                              state is! LogOutLoadingState,
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
                                                child:
                                                    CircularProgressIndicator(
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
                                          condition:
                                              state is! DeleteLoadingState,
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
                                                  DeleteAccountCubit.get(
                                                          context)
                                                      .deleteAccount();
                                                },
                                              ),
                                          fallback: (context) => const Center(
                                                child:
                                                    CircularProgressIndicator(
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
                      ),
                      appBar: AppBar(
                        iconTheme: IconThemeData(
                          size: height*0.026+width*0.017,
                          color: Colors.white
                        ),
                          toolbarHeight: height*0.068,
                          backgroundColor: green,
                          centerTitle: true,
                          title:  Text(
                            'محلاتي',
                            style: TextStyle(fontFamily:'Cairo',fontSize:height*0.023+width*0.012),
                          )),
                      body: RefreshIndicator(
                        color: Colors.white,
                        backgroundColor: green,
                        onRefresh: () async {
                          context.read<GetStoreCubit>().getVendorShop();
                          await Future.delayed(const Duration(seconds: 2));
                        },
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding:  EdgeInsets.all(height*0.013+width*0.008),
                            child: Column(
                              textDirection: TextDirection.rtl,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    child: Column(
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: getVendorShopModel
                                                  .shopsData?.length ??
                                              0,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        StoreProduct(
                                                      storeId:
                                                          getVendorShopModel
                                                                  .shopsData![
                                                                      index]
                                                                  .id ??
                                                              0,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                decoration:const BoxDecoration(
                                                  color: lightGrey,
                                                ),
                                                child: Padding(
                                                  padding:const EdgeInsets.only(right: 5.0,bottom: 5,top: 5),
                                                  child: Row(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(height*0.006+width*0.004),
                                                        child: Image.network(
                                                          EndPoint.imageShopUrl +
                                                              (getVendorShopModel
                                                                      .shopsData![
                                                                          index]
                                                                      .photo ??
                                                                  'sd'),
                                                          fit: BoxFit.cover,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                          height:height*0.1,
                                                        ),
                                                      ),
                                                       SizedBox(
                                                          width: width*0.035),
                                                      Expanded(
                                                        child: Column(
                                                          textDirection:
                                                              TextDirection
                                                                  .rtl,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              getVendorShopModel
                                                                      .shopsData![
                                                                          index]
                                                                      .name ??
                                                                  'ds',
                                                              style:
                                                                   TextStyle(
                                                                fontSize: height*0.015+width*0.012,
                                                                fontFamily: "Cairo",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: height*0.004,
                                                            ),
                                                            Row(
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              children: [
                                                                 Icon(Icons
                                                                    .location_on,color: green,size: height*0.025+width*0.01,),
                                                                const SizedBox(
                                                                    width:
                                                                        5),
                                                                Text(
                                                                  getVendorShopModel
                                                                          .shopsData![index]
                                                                          .location
                                                                          ?.city ??
                                                                      'ds',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily: "Cairo",
                                                                    fontSize:
                                                                        height*0.012+width*0.008,
                                                                    color: Colors
                                                                            .grey[
                                                                        800],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: height*0.004,
                                                            ),
                                                            Row(
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              children: [
                                                                 Icon(
                                                                    Icons
                                                                        .star,size: height*0.025+width*0.01,
                                                                    color: Colors
                                                                        .yellow),
                                                                Text(
                                                                    // getVendorShopModel
                                                                    //     ?.shopsData![
                                                                    // index]
                                                                    //     .avgStars ??
                                                                    '5',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          height*0.015+width*0.01,
                                                                      color: Colors
                                                                          .grey[800],
                                                                    )),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return  SizedBox(height: height*0.02);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator());
            },
          ),
        );
      }),

    );
  }
}
