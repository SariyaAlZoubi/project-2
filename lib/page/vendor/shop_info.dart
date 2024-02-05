import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/component/helper.dart';
import 'package:untitled1/model/store/get_shop_info.dart';

import '../../bloc/get_shop_info/get_shop_info_cubit.dart';
import '../../bloc/get_shop_info/get_shop_info_state.dart';

class ShopInfo extends StatelessWidget {
  final int shopId;

  const ShopInfo({
    super.key,
    required this.shopId,
  });

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => GetShopInfoCubit()..getShopInfo(id: shopId),
      child: BlocConsumer<GetShopInfoCubit, GetShopInfoState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          GetShopInfoModel? getShopModel =
              GetShopInfoCubit.get(context).getShopInfoModel;
          String storeStatus =
              getShopModel?.shopData?.isOpen == 1 ? 'مفتوح' : 'مغلق';
          const Color green = Color(0xFF169956);
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return getShopModel != null
                  ? Scaffold(
                      appBar: AppBar(
                        iconTheme: IconThemeData(
                            size: height*0.026+width*0.017,
                            color: Colors.white
                        ),
                        toolbarHeight: height*0.068,
                        backgroundColor: green,
                        title:  Text(
                          'تفاصيل المتجر',
                          style: TextStyle(fontFamily: 'Cairo',fontSize: height*0.022+width*0.013),
                        ),
                        centerTitle: true,
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            textDirection: TextDirection.rtl,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight * 0.3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      EndPoint.imageShopUrl +
                                          (getShopModel.shopData?.photo ??
                                              'sd'),
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                ':اسم المتجر',
                                style: TextStyle(
                                  color: green,
                                  fontFamily: 'Cairo',
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                              Text(
                                getShopModel.shopData?.name ?? 'ds',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                ':رقم الهاتف',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: green,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                              Text(
                                ' ${getShopModel.shopData?.phoneNumber ?? 'ds'}',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                ':المدينة',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: green,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                              Text(
                                ' ${getShopModel.shopData?.location?.city ?? 'ds'}',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                ':حالة المتجر',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: green,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                              Text(
                                ' $storeStatus',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                ':التوصيف',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: green,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                              Text(
                                getShopModel.shopData?.description ?? 'ds',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(green),
                      )));
            },
          );
        },
      ),
    );
  }
}
