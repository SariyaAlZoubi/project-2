import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/page/user/store_product.dart';

import '../../bloc/search_cubit/search_store_cubit.dart';
import '../../bloc/search_cubit/search_store_state.dart';
import '../../component/helper.dart';
import '../../model/store/serach_store_model.dart';

class SearchStore extends StatelessWidget {
  const SearchStore({super.key});

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
          SearchStoreModel? searchModel =
              SearchStoreCubit.get(context).searchModel;

          return Scaffold(
              body: Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Column(
                textDirection: TextDirection.rtl,
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
                                textDirection: TextDirection.rtl,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    SearchStoreCubit.get(context)
                                        .searchByChar(text: value);
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'البحث عن متاجر ',
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
                  if (state is LoadingState) const LinearProgressIndicator(),
                  if (state is SuccessState)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          textDirection: TextDirection.rtl,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height - 150,
                              ),
                              child: ListView.separated(
                                reverse: true,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: searchModel?.shopsData?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => StoreProduct(
                                                storeId: searchModel
                                                        .shopsData![index].id ??
                                                    0),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF4F4F4),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: Row(
                                          textDirection: TextDirection.rtl,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                EndPoint.imageShopUrl +
                                                    searchModel!
                                                        .shopsData![index]
                                                        .photo!,
                                                fit: BoxFit.cover,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                                height: double.infinity,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                textDirection:
                                                    TextDirection.rtl,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    searchModel
                                                            .shopsData![index]
                                                            .name ??
                                                        'ds',
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    children: [
                                                      const Icon(
                                                          Icons.location_on),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        searchModel
                                                                .shopsData![
                                                                    index]
                                                                .location
                                                                ?.city ??
                                                            'ds',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    children: [
                                                      const Icon(Icons.star,
                                                          color: Colors.yellow),
                                                      Text(
                                                          // Searchmodel?.shopsData![index].avgStars?? '5',
                                                          '5',
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors
                                                                .grey[600],
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
            ),
          ));
        },
      ),
    );
  }
}
