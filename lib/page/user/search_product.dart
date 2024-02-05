import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/component/helper.dart';
import 'package:untitled1/model/product/search_product_model.dart';
import 'package:untitled1/page/user/product_details.dart';
import '../../bloc/search_cubit/search_store_cubit.dart';
import '../../bloc/search_cubit/search_store_state.dart';

class SearchProduct extends StatelessWidget {
  const SearchProduct({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => SearchStoreCubit(),
      child: BlocConsumer<SearchStoreCubit, SearchStoreState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          SearchProductModel? searchProductModel =
              SearchStoreCubit.get(context).searchProductModel;

          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Scaffold(
                body: Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.07,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.018),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
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
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      SearchStoreCubit.get(context)
                                          .searchProduct(text: value);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'البحث عن منتجات ',
                                    hintStyle: TextStyle(
                                      fontSize: screenWidth * 0.04,
                                      fontFamily: 'Cairo',
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (state is SearchProductLoadingState)
                      const LinearProgressIndicator(),
                    Expanded(
                      child: GridView.builder(
                          padding: EdgeInsets.all(screenWidth * 0.036),
                          itemCount:
                              searchProductModel?.productsData?.length ?? 0,
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
                                        builder: (context) => ProductDetails(
                                              id: searchProductModel
                                                      .productsData![index]
                                                      .id ??
                                                  1,
                                            )));
                              },
                              child: Stack(
                                children: [
                                  Card(
                                      child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: Image.network(
                                            EndPoint.imageUrl +
                                                (searchProductModel
                                                        ?.productsData![index]
                                                        .picture ??
                                                    'sd'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(
                                              screenWidth * 0.018),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                searchProductModel
                                                        ?.productsData![index]
                                                        .name ??
                                                    'ds',
                                                style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Cairo'),
                                              ),
                                              SizedBox(
                                                  height: screenWidth * 0.007),
                                              Text(
                                                '\$${searchProductModel?.productsData![index].price ?? 'ds'}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                  Positioned(
                                    top: constraints.maxWidth * 0.48,
                                    left: constraints.maxWidth * 0.001,
                                    child: Visibility(
                                      visible: true,
                                      child: IconButton(
                                        icon: CircleAvatar(
                                          radius: constraints.maxWidth * 0.030,
                                          backgroundColor: SearchStoreCubit.get(
                                                              context)
                                                          .favourites[
                                                      searchProductModel!
                                                          .productsData?[index]
                                                          .id] ==
                                                  1
                                              ? Colors.red
                                              : Colors.grey,
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.white,
                                            size: constraints.maxWidth * 0.05,
                                          ),
                                        ),
                                        onPressed: () {
                                          SearchStoreCubit.get(context)
                                              .changeFavourite(
                                            id: searchProductModel
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
                    )
                  ],
                ),
              ),
            ));
          });
        },
      ),
    );
  }
}
