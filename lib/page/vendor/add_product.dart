import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/get_product_shop_id/get_product_state.dart';

import '../../bloc/get_product_shop_id/get_product_cubit.dart';
import '../../component/helper.dart';
import '../../component/textfield.dart';

class AddProduct extends StatelessWidget {
  final int id;
  final name = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();
  final quantity = TextEditingController();

   AddProduct({
    super.key,
    required this.id,
  });


  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;

    const Color green = Color(0xFF169956);
    const Color secondaryColor = Color(0xFF1F9E67);
    return BlocProvider(
      create: (context) => GetProductCubit(),
      child: BlocConsumer<GetProductCubit, GetProductByShopState>(
        listener: (context, state) {
          if (state is AddProductSuccessState) {
            flutterToast(state.model.message ?? '', "success");
          }
        },
        builder: (context, state) {
          File? image = GetProductCubit.get(context).addImage;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: green,
              iconTheme: IconThemeData(
                  size: height*0.026+width*0.017,
                  color: Colors.white
              ),
              toolbarHeight: height*0.068,
              title:  Text(
                'اضافة منتج',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize:height*0.022+width*0.013,
                ),
              ),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              GetProductCubit.get(context).getImage();
                            },
                            child: Center(
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(constraints.maxWidth*0.01+constraints.maxHeight*0.0155)
                                ),
                                child: Image(
                                  image: image == null
                                      ? const AssetImage('images/phpto.jpg')
                                      : FileImage(image) as ImageProvider<Object>,
                                  fit: BoxFit.cover,
                                  width: constraints.maxWidth*0.9,
                                  height: constraints.maxHeight * 0.3,
                                ),
                              ),
                            )),
                         SizedBox(
                          height: constraints.maxHeight*0.025,
                        ),
                         Text(
                          'اسم المنتج ',
                          style: TextStyle(
                              fontFamily: 'Cairo',
                            fontSize: height*0.016+width*0.01,
                              color: secondaryColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: textFormFieldCompany(
                            width: width,
                              height: height,
                              controller: name, hintText: 'اسم المنتج'),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                         Text(
                          'ادخل التوصيف  ',
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: height*0.016+width*0.01,
                              color: secondaryColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: textFormFieldCompany(
                              width: width,
                              height: height,
                              controller: description,
                              hintText: 'ادخل التوصيف '),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                         Text(
                          'ادخل السعر  ',
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: height*0.016+width*0.01,
                              color: secondaryColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: textFormFieldCompany(
                              width: width,
                              height: height,
                              controller: price, hintText: 'ادخل السعر '),
                        ),
                         Text(
                          'ادخل الكمية  ',
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: height*0.016+width*0.01,
                              color: secondaryColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: textFormFieldCompany(
                              width: width,
                              height: height,
                              controller: quantity, hintText: 'ادخل الكمية '),
                        ),
                        SizedBox(
                          height: constraints.maxHeight*0.017,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: constraints.maxWidth * 0.4,
                            child: ConditionalBuilder(
                                condition: state is! AddProductLoadingState,
                                builder: (context) => ElevatedButton.icon(
                                      onPressed: () {
                                        GetProductCubit.get(context).addProduct(
                                          name: name.text,
                                          description: description.text,
                                          price: price.text,
                                          quantity: quantity.text,
                                          shopId: id,
                                        );
                                      },
                                      icon:  Icon(Icons.add,size:height*0.017+width*0.01),
                                      label: const Text(
                                        'اضافة',
                                        style: TextStyle(fontFamily: 'Cairo'),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: green,
                                        textStyle:  TextStyle(
                                          fontSize: height*0.017+width*0.01,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                fallback: (context) => const Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                green),
                                      ),
                                    )),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
