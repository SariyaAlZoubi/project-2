import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/get_product_category/get_product_state.dart';

import '../../bloc/get_product_category/get_product_cubit.dart';
import '../../component/helper.dart';
import '../../model/product/get_favourite_model.dart';
import 'favorite_shop.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetProductCubit()..getAllFavourite(),
      child: BlocConsumer<GetProductCubit, GetProductByCategoryState>(
        listener: (context, state) {
          if (state is GetAllFavouriteSuccessState) {
            if (state.getFavouriteModel!.favoriteProductsData!.isEmpty) {
              flutterToast('لا يوجد اي عنصر في المفضلة بعد !', "error");
            }
          }
        },
        builder: (context, state) {
          GetFavoriteModel? getFavoriteModel =
              GetProductCubit.get(context).getFavouriteModel;
          const Color green = Color(0xFF169956);
          return getFavoriteModel != null
              ? Scaffold(
                  appBar: AppBar(
                      backgroundColor: green,
                      centerTitle: true,
                      title: const Text(
                        'المفضلة ',
                        style: TextStyle(fontFamily: 'Cairo'),
                      ),
                      actions: [
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'ShopFavourite') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FavouriteShop(),
                                ),
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            List<PopupMenuItem<String>> items = [];

                            items.add(
                              const PopupMenuItem(
                                value: 'ShopFavourite',
                                child: ListTile(
                                  leading: Icon(Icons.store_rounded),
                                  title: Text(' المتاجر المفضلة'),
                                  subtitle: Text('المتاجر المفضلة'),
                                ),
                              ),
                            );

                            return items;
                          },
                        ),
                      ]),
                  body: Container(
                    color: Colors.white60,
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount:
                                getFavoriteModel.favoriteProductsData?.length ??
                                    0,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  (MediaQuery.of(context).size.width > 600)
                                      ? 3
                                      : 2,
                              childAspectRatio: 0.70,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                children: [
                                  Card(
                                    color: Colors.white70,
                                    child: Column(
                                      textDirection: TextDirection.rtl,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: Image.network(
                                            EndPoint.imageUrl +
                                                (getFavoriteModel
                                                        .favoriteProductsData![
                                                            index]
                                                        .picture ??
                                                    'sd'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            textDirection: TextDirection.rtl,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                getFavoriteModel
                                                        .favoriteProductsData![
                                                            index]
                                                        .name ??
                                                    'ds',
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '\$${getFavoriteModel.favoriteProductsData![index].price ?? 'ds'}',
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Visibility(
                                      visible: false,
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(green),
                ));
        },
      ),
    );
  }
}
