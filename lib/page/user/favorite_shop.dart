import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/get_store/get_store_cubit.dart';
import '../../bloc/get_store/get_store_state.dart';
import '../../component/helper.dart';
import '../../model/store/shop_favorite.dart';
import '../../theme/colors.dart';

class FavouriteShop extends StatelessWidget {
  const FavouriteShop({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return BlocProvider(
        create: (context) => GetStoreCubit()..getStoreFavorite(),
        child: BlocConsumer<GetStoreCubit, GetStoreState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            FavoriteStoreModel? getFavoriteModel =
                GetStoreCubit.get(context).getFavoriteModel;
            double screenWidth = MediaQuery.of(context).size.width;
            double screenHeight = MediaQuery.of(context).size.height;

            return getFavoriteModel != null
                ? Scaffold(
                    appBar: AppBar(
                      backgroundColor: green,
                      title: const Text(
                        'مفضلة المتاجر',
                        style: TextStyle(fontFamily: 'Cairo'),
                      ),
                    ),
                    body: Column(
                      textDirection: TextDirection.rtl,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              textDirection: TextDirection.rtl,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height -
                                            150,
                                  ),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: getFavoriteModel
                                            .favoriteShopData?.length ??
                                        0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Card(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: screenHeight * 0.01),
                                          child: Stack(
                                            children: [
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    child: Image(
                                                      image: NetworkImage(EndPoint
                                                              .imageShopUrl +
                                                          getFavoriteModel
                                                              .favoriteShopData![
                                                                  index]
                                                              .photo!),
                                                      fit: BoxFit.cover,
                                                      height: 100,
                                                      width: 100,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: screenWidth * 0.026,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    children: [
                                                      Text(
                                                        getFavoriteModel
                                                            .favoriteShopData![
                                                                index]
                                                            .name!,
                                                        style: TextStyle(
                                                            fontFamily: "Cairo",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                screenHeight *
                                                                        0.015 +
                                                                    screenWidth *
                                                                        0.01),
                                                      ),
                                                      SizedBox(
                                                        height: screenHeight *
                                                            0.0004,
                                                      ),
                                                      Text(
                                                        "${getFavoriteModel.favoriteShopData![index].location?.city!}",
                                                        style: TextStyle(
                                                            fontFamily: "Cairo",
                                                            fontSize:
                                                                screenHeight *
                                                                        0.015 +
                                                                    screenWidth *
                                                                        0.01,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        height: screenHeight *
                                                            0.0004,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color:
                                                                Colors.yellow,
                                                            size: screenHeight *
                                                                    0.02 +
                                                                screenWidth *
                                                                    0.015,
                                                          ),
                                                          Text(
                                                            '5',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Cairo",
                                                                fontSize: screenHeight *
                                                                        0.015 +
                                                                    screenWidth *
                                                                        0.01,
                                                                color: green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    'مفتوح',
                                                    style: TextStyle(
                                                        fontSize: screenHeight *
                                                                0.015 +
                                                            screenWidth * 0.01,
                                                        fontFamily: "Cairo",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: green),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(height: 10);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(green),
                    )));
          },
        ),
      );
    });
  }
}
