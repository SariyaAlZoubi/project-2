

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/get_product_category/get_product_state.dart';
import 'package:untitled1/model/product/get_product_by_category_model.dart';
import 'package:untitled1/page/user/product_details.dart';
import 'package:untitled1/page/user/search_product.dart';
import '../../bloc/get_product_category/get_product_cubit.dart';
import '../../component/helper.dart';
import '../../model/category/get_category.dart';
import '../../theme/colors.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetProductCubit()
        ..getProductCategory(id: 2)
        ..getCategory(),
      child: BlocConsumer<GetProductCubit, GetProductByCategoryState>(
        listener: (context, state) {
          if (state is SuccessChangeFavouriteState) {
            if ((state.model.status ?? false)) {
              flutterToast(state.model.message.toString(), "success");
            }
          }
        },
        builder: (context, state) {
          GetProductByCategoryModel? getProductByCategoryModel =
              GetProductCubit.get(context).getProductModel;
          CategoryModel? getCategoryModel =
              GetProductCubit.get(context).getCategoryModel;
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            double screenWidth = MediaQuery.of(context).size.width;
            double screenHeight = MediaQuery.of(context).size.height;

            return ((getProductByCategoryModel != null) &&
                    (getCategoryModel != null))
                ? Container(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Column(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          SizedBox(
                            height: screenHeight * 0.07,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SearchProduct()));
                            },
                            child: FractionallySizedBox(
                              widthFactor: 0.9,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.018),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.search_outlined,
                                          size: screenWidth * 0.06,
                                        ),
                                        onPressed: () {},
                                      ),
                                      Expanded(
                                        child: TextField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                            hintText: 'البحث ',
                                            hintStyle: TextStyle(
                                                fontSize: screenWidth * 0.04,
                                                fontFamily: 'Cairo'),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth * 0.027),
                                child: Text(
                                  'التصنيفات',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: screenWidth * 0.055,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          SizedBox(
                            height: screenHeight * 0.120,
                            child: ListView.builder(
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  getCategoryModel.categories?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.018),
                                    child: Column(
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.053),
                                          child: Container(
                                            width: screenWidth * 0.220,
                                            height: screenWidth * 0.170,
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFF2BC0E4),
                                                  Color(0xFFEAECC6),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                'images/shop3.jpg',
                                                width: screenWidth * 0.099,
                                                height: screenWidth * 0.099,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.002),
                                        Text(
                                          getCategoryModel
                                                  .categories![index].name ??
                                              'ds',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Cairo'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth * 0.027),
                                child: Text(
                                  'المنتجات',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: screenWidth * 0.055,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: GridView.builder(
                                padding: EdgeInsets.all(screenWidth * 0.036),
                                itemCount: getProductByCategoryModel
                                        .productsData?.length ??
                                    0,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.70,
                                  crossAxisSpacing: screenWidth * 0.036,
                                  mainAxisSpacing: screenWidth * 0.036,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetails(
                                                    id: getProductByCategoryModel
                                                            .productsData![
                                                                index]
                                                            .id ??
                                                        1,
                                                  )));
                                    },
                                    child: Stack(
                                      children: [
                                        Card(
                                          child: Column(
                                            textDirection: TextDirection.rtl,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              AspectRatio(
                                                aspectRatio: 1,
                                                child: Image.network(
                                                  EndPoint.imageUrl +
                                                      (getProductByCategoryModel
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
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      getProductByCategoryModel
                                                              .productsData![
                                                                  index]
                                                              .name ??
                                                          'ds',
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.03,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'Cairo'),
                                                    ),
                                                    SizedBox(
                                                        height: screenWidth *
                                                            0.007),
                                                    Text(
                                                      '\$${getProductByCategoryModel.productsData![index].price ?? 'ds'}',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: constraints.maxWidth * 0.48,
                                          left: constraints.maxWidth * 0.001,
                                          child: Visibility(
                                            visible: true,
                                            child: IconButton(
                                              icon: CircleAvatar(
                                                radius: constraints.maxWidth *
                                                    0.030,
                                                backgroundColor: GetProductCubit
                                                                    .get(context)
                                                                .favourites[
                                                            getProductByCategoryModel
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
                                                  id: getProductByCategoryModel
                                                      .productsData?[index].id,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(green),
                  ));
          });
        },
      ),
    );
  }
}
