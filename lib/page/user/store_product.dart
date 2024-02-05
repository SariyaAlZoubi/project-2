
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/get_product_shop_id/get_product_state.dart';
import 'package:untitled1/model/product/get_product_by_shop.dart';
import 'package:untitled1/page/user/product_details.dart';
import '../../bloc/get_product_shop_id/get_product_cubit.dart';
import '../../component/helper.dart';
import '../../network/local/cache.dart';
import '../vendor/add_product.dart';
import '../vendor/editStore.dart';
import '../vendor/shop_info.dart';

class StoreProduct extends StatelessWidget {
 final int storeId;

  const StoreProduct({
    super.key,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => GetProductCubit()..getProductByShopId(id: storeId),
      child: BlocConsumer<GetProductCubit, GetProductByShopState>(
        listener: (context, state) {
          if (state is SuccessState) {}
          if (state is SuccessChangeFavouriteState) {
            if ((state.model.status ?? false)) {
              flutterToast(state.model.message.toString(), "success");
            }
          }

          if (state is OpenCloseSuccessState) {
            flutterToast(state.model.message.toString(), "success");
          }

          if (state is DeleteProductSuccessState) {
            flutterToast(state.model.message.toString(), "success");
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          const Color green = Color(0xFF169956);
          const Color secondaryColor = Color(0xFF1F9E67);
          String type = CacheHelper.getData(key: 'type');
          double screenWidth = MediaQuery.of(context).size.width;
          GetProductModel? getProductModel =
              GetProductCubit.get(context).getProductModel;

          return getProductModel != null
              ? LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                  return Scaffold(
                    appBar: AppBar(
                        backgroundColor: green,
                        toolbarHeight: height*0.068,
                      iconTheme: IconThemeData(
                          size: height*0.026+width*0.017,
                          color: Colors.white
                      ),
                        title:  Text(
                          'المنتجات',
                          style: TextStyle(fontFamily: 'Cairo',fontSize: height*0.023+width*0.012),
                        ),
                        centerTitle: true,
                        actions: [
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'info') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ShopInfo(shopId: storeId),
                                  ),
                                );
                              } else if (value == 'edit') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditStore(id: storeId),
                                  ),
                                );
                              } else {
                                GetProductCubit.get(context)
                                    .openCloseShop(id: storeId);
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              String? userType =
                                  CacheHelper.getData(key: 'type');
                              List<PopupMenuItem<String>> items = [];

                              items.add(
                                const PopupMenuItem(
                                  value: 'info',
                                  child: ListTile(
                                    leading: Icon(Icons.info),
                                    title: Text('معلومات المتجر'),
                                    subtitle: Text('عرض تفاصيل المتجر'),
                                  ),
                                ),
                              );

                              if (userType == 'vendor') {
                                items.add(
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: ListTile(
                                      leading: Icon(Icons.edit),
                                      title: Text('تعديل معلومات المتجر'),
                                      subtitle: Text('تعديل تفاصيل المتجر'),
                                    ),
                                  ),
                                );
                              }

                              if (userType == 'vendor') {
                                items.add(
                                  const PopupMenuItem(
                                    value: 'إغلاق/فتح المتجر',
                                    child: ListTile(
                                      leading: Icon(Icons.edit),
                                      title: Text('إغلاق/فتح المتجر'),
                                      subtitle: Text('إغلاق/فتح المتجر'),
                                    ),
                                  ),
                                );
                              }

                              return items;
                            },
                          ),
                        ]),
                    body: getProductModel.productsData!.isEmpty
                        ? RefreshIndicator(
                            backgroundColor: green,
                            color: Colors.white,
                            onRefresh: () async {
                              context
                                  .read<GetProductCubit>()
                                  .getProductByShopId(id: storeId);
                              await Future.delayed(const Duration(seconds: 2));
                            },
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                height: height*0.8,
                                child: Center(
                                  child: Text(
                                    'لا يوجد منتجات',
                                    style: TextStyle(
                                        fontFamily: "Cairo",
                                        fontSize: constraints.maxHeight * 0.02 +
                                            constraints.maxWidth * 0.02,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            backgroundColor: green,
                            color: Colors.white,
                            onRefresh: () async {
                              context
                                  .read<GetProductCubit>()
                                  .getProductByShopId(id: storeId);
                              await Future.delayed(const Duration(seconds: 2));
                            },
                            child: GridView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.all(screenWidth * 0.036),
                                itemCount:
                                    getProductModel.productsData?.length ?? 0,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.70,
                                  crossAxisSpacing: screenWidth * 0.036,
                                  mainAxisSpacing: screenWidth * 0.036,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onLongPress: () {
                                      if (type == "vendor") {
                                        showDialog(
                                          context: context,
                                          builder: (context) {

                                            return AlertDialog(
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: height>1400?height*0.03+width*0.013:(height>800?height*0.038+width*0.02:height*0.046+width*0.024),
                                                      decoration: BoxDecoration(
                                                          color: green,
                                                          borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child: TextButton(
                                                          child:const Text('تعديل',style: TextStyle(
                                                              fontFamily: "Cairo",
                                                              color: Colors.white
                                                          ),) ,
                                                          onPressed: () {

                                                          }
                                                      ),
                                                    ),
                                                     SizedBox(
                                                      width: width*0.1,
                                                    ),
                                                    Container(
                                                      height: height>1400?height*0.03+width*0.013:(height>800?height*0.038+width*0.02:height*0.046+width*0.024),
                                                      decoration: BoxDecoration(
                                                          color: green,
                                                          borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child: TextButton(
                                                          child:const Text('حذف ',style: TextStyle(
                                                              fontFamily: "Cairo",
                                                              color: Colors.white
                                                          ),) ,
                                                          onPressed: () {
                                                            GetProductCubit.get(
                                                                context)
                                                                .deleteProduct(
                                                                id: getProductModel
                                                                    .productsData?[
                                                                index]
                                                                    .id);
                                                          }
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetails(
                                                    id: getProductModel
                                                        .productsData![index]
                                                        .id!,
                                                  )));
                                    },
                                    child: Stack(
                                      children: [
                                        Card(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              textDirection: TextDirection.rtl,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                AspectRatio(
                                                  aspectRatio: 1,
                                                  child: Image.network(
                                                    EndPoint.imageUrl +
                                                        (getProductModel
                                                                .productsData![
                                                                    index]
                                                                .picture ??
                                                            'sd'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(
                                                      screenWidth * 0.018),
                                                  child: Column(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        getProductModel
                                                                .productsData![
                                                                    index]
                                                                .name ??
                                                            'ds',
                                                        style: TextStyle(
                                                            fontSize:
                                                                screenWidth *
                                                                    0.04,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Cairo'),
                                                      ),
                                                      SizedBox(
                                                          height: screenWidth *
                                                              0.007),
                                                      Text(
                                                        '${getProductModel.productsData![index].price} ل.س ',
                                                        style:  TextStyle(
                                                          fontSize: screenWidth *
                                                              0.035,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        textDirection:
                                                            TextDirection.rtl,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: constraints.maxWidth * 0.48,
                                          left: constraints.maxWidth * 0.001,
                                          child: Visibility(
                                            visible: type == 'customer',
                                            child: IconButton(
                                              icon: CircleAvatar(
                                                radius: constraints.maxWidth *
                                                    0.030,
                                                backgroundColor: GetProductCubit
                                                                    .get(context)
                                                                .favourites[
                                                            getProductModel
                                                                .productsData?[
                                                                    index]
                                                                .id] ==
                                                        1
                                                    ? Colors.red
                                                    : Colors.grey,
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: Colors.white,
                                                  size: constraints.maxWidth *
                                                      0.05,
                                                ),
                                              ),
                                              onPressed: () {
                                                GetProductCubit.get(context)
                                                    .changeFavourite(
                                                  id: getProductModel
                                                      .productsData?[index].id,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })),
                    floatingActionButton: type == 'vendor'
                        ? Transform.translate(
                      offset:const Offset(10, 5),
                      child: SizedBox(
                        height: height*0.1,
                        width: width*0.15,
                        child: FittedBox(
                          child: FloatingActionButton(

                            backgroundColor: secondaryColor,
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>  AddProduct(id: storeId)));
                            },
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ),
                    )
                        : null,
                  );
                })
              : const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(green),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
