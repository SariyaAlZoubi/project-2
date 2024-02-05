import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:untitled1/page/user/search_store.dart';
import 'package:untitled1/page/user/store_product.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../bloc/get_store/get_store_cubit.dart';
import '../../bloc/get_store/get_store_state.dart';
import '../../component/helper.dart';
import '../../theme/colors.dart';
import 'cart.dart';
import 'package:badges/badges.dart' as badges;

class StorePage extends StatelessWidget {
 const  StorePage({super.key});

 final List<Map<String, dynamic>> categories = const [
    {
      'name': 'أغذية',
      'image': 'images/food.jpg',
    },
    {
      'name': 'ألبسة',
      'image': 'images/clothes.jpg',
    },
    {
      'name': 'الكترونيات',
      'image': 'images/ele.jpg',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
          backgroundColor: lightGrey,
          body: BlocProvider(
            create: (context) => GetStoreCubit()..getCart()..getStoreByCategory(id: 1),
            child: BlocConsumer<GetStoreCubit, GetStoreState>(
              listener: (context, state) {
                if (state is StateBloc) {
                  GetStoreCubit.get(context)
                      .getStoreByCategory(id: GetStoreCubit.get(context).id);
                }
              },
              builder: (context, state) {
                GetStoreCubit getStoreCubit = GetStoreCubit.get(context);
                int id = getStoreCubit.id;

                return GetStoreCubit.num!=null?SafeArea(
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 28.0, left: 8, right: 8),
                    child: LayoutBuilder(
                      builder: (context, constrain) {
                        double height = constrain.maxHeight;
                        double width = constrain.maxWidth;
                        return SingleChildScrollView(
                            child: Column(
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(
                                  height: height * 0.067,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: height>1300?const EdgeInsets.all(15.0):const EdgeInsets.all(0),
                                    child: Row(
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        IconButton(
                                          onPressed: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => const Cart()));
                                          },
                                          icon: badges.Badge(
                                            badgeStyle:const  BadgeStyle(padding: EdgeInsets.all(5)),
                                            badgeContent: Text("${GetStoreCubit.num}",style: TextStyle(color: Colors.white,fontSize: height*0.015+width*0.009),),
                                            child: Icon(
                                              Icons.shopping_cart_outlined,
                                              color: green,
                                              size: height * 0.04,
                                            ) ,
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                color: Colors.grey.shade300,
                                              ),
                                              child: TextFormField(

                                                textDirection: TextDirection.rtl,
                                                textAlignVertical:
                                                TextAlignVertical.center,
                                                onChanged: (value)
                                                {
                                                },
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                     EdgeInsets.symmetric(
                                                        vertical: height>800?0:6,
                                                        horizontal: 20),
                                                    hintText: "البحث",
                                                    border: InputBorder.none,
                                                    hintStyle: const TextStyle(
                                                        fontFamily: "Cairo"),
                                                    hintTextDirection:
                                                    TextDirection.rtl,
                                                    prefixIcon: ZoomTapAnimation(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                  const SearchStore()));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                          child: Container(
                                                            width: width * 0.063,
                                                            decoration: BoxDecoration(
                                                              color: green,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                            ),
                                                            child: const Center(
                                                              child: Icon(
                                                                  IconlyLight.filter,
                                                                  color:
                                                                  Colors.white),
                                                            ),
                                                          ),
                                                        ))),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.04),
                                SizedBox(
                                  height: height * 0.086,
                                  child: ListView.builder(
                                    reverse: true,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categories.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          ZoomTapAnimation(
                                            onTap: () {
                                              id = index + 1;
                                              getStoreCubit.changeId(id);
                                            },
                                            beginDuration:
                                            const Duration(milliseconds: 50),
                                            endDuration:
                                            const Duration(milliseconds: 100),
                                            child: Container(
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              margin:
                                              const EdgeInsets.only(right: 8),
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    width: width * 0.3,
                                                    child: Image(
                                                      image: AssetImage(
                                                          categories[index]
                                                          ['image']),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    right: 0,
                                                    bottom: 0,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withAlpha(110),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                            "${categories[index]['name']}",
                                                            textAlign:
                                                            TextAlign.center,
                                                            style: TextStyle(
                                                                fontFamily: "Cairo",
                                                                color: Colors.white,
                                                                fontWeight:
                                                                FontWeight.w600,
                                                                fontSize: height *
                                                                    0.0155 +
                                                                    width * 0.01)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: width * 0.01),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: height * 0.025),
                                GetStoreCubit.get(context).getStoreModel != null
                                    ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: GetStoreCubit.get(context)
                                        .getStoreModel!
                                        .shopsData!
                                        .length,
                                    itemBuilder: (context, index) => Column(
                                      children: [
                                        ZoomTapAnimation(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    StoreProduct(
                                                        storeId: getStoreCubit
                                                            .getStoreModel!
                                                            .shopsData![
                                                        index]
                                                            .id ??
                                                            0),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: height * 0.01),
                                              child: Stack(
                                                children: [
                                                  Row(
                                                    textDirection:
                                                    TextDirection.rtl,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            5),
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        child: Image(
                                                          image: NetworkImage(EndPoint
                                                              .imageShopUrl +
                                                              GetStoreCubit.get(
                                                                  context)
                                                                  .getStoreModel!
                                                                  .shopsData![
                                                              index]
                                                                  .photo!),
                                                          fit: BoxFit.cover,
                                                          height: 100,
                                                          width: 100,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                        width * 0.026,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        textDirection:
                                                        TextDirection
                                                            .rtl,
                                                        children: [
                                                          Text(
                                                            "${GetStoreCubit.get(context).getStoreModel!.shopsData![index].name}",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                "Cairo",
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize: height *
                                                                    0.015 +
                                                                    width *
                                                                        0.01),
                                                          ),
                                                          SizedBox(
                                                            height: height *
                                                                0.0004,
                                                          ),
                                                          Text(
                                                            "${GetStoreCubit.get(context).getStoreModel!.shopsData![index].location!.city}",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                "Cairo",
                                                                fontSize: height *
                                                                    0.015 +
                                                                    width *
                                                                        0.01,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                          SizedBox(
                                                            height: height *
                                                                0.0004,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .yellow,
                                                                size: height *
                                                                    0.02 +
                                                                    width *
                                                                        0.015,
                                                              ),
                                                              Text(
                                                                '5',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    "Cairo",
                                                                    fontSize: height *
                                                                        0.015 +
                                                                        width *
                                                                            0.01,
                                                                    color:
                                                                    green,
                                                                    fontWeight:
                                                                    FontWeight.w600),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            GetStoreCubit.get(
                                                                context)
                                                                .getStoreModel!
                                                                .shopsData![
                                                            index]
                                                                .isOpen ==
                                                                1
                                                                ? "مفتوح"
                                                                : "مغلق",
                                                            style: TextStyle(
                                                                fontSize: height *
                                                                    0.015 +
                                                                    width *
                                                                        0.01,
                                                                fontFamily:
                                                                "Cairo",
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                color: green),
                                                          ),
                                                          IconButton(
                                                            icon: CircleAvatar(
                                                              radius: constraints
                                                                  .maxWidth *
                                                                  0.035,
                                                              backgroundColor: GetStoreCubit.get(
                                                                  context)
                                                                  .favourites[GetStoreCubit.get(
                                                                  context)
                                                                  .getStoreModel
                                                                  ?.shopsData?[
                                                              index]
                                                                  .id] ==
                                                                  1
                                                                  ? Colors.red
                                                                  : Colors.grey,
                                                              child: Icon(
                                                                Icons.favorite,
                                                                color:
                                                                Colors.white,
                                                                size: constraints
                                                                    .maxWidth *
                                                                    0.05,
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              GetStoreCubit.get(
                                                                  context)
                                                                  .changeFavourite(
                                                                id: GetStoreCubit
                                                                    .get(
                                                                    context)
                                                                    .getStoreModel
                                                                    ?.shopsData?[
                                                                index]
                                                                    .id,
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: height * 0.018),
                                      ],
                                    ))
                                    : const Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(green),
                                  ),
                                )
                              ],
                            ));
                      },
                    ),
                  ),
                ):const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(green),
                  ),
                );
              },
            ),
          ));
    });
  }
}
