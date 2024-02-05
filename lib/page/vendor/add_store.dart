import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/add_store/add_store_cubit.dart';
import '../../bloc/add_store/add_store_state.dart';
import '../../bloc/location/add_location_cubit.dart';
import '../../bloc/location/add_location_state.dart';
import '../../component/helper.dart';
import '../../component/textfield.dart';

class AddStore extends StatelessWidget {
   AddStore({super.key});
  final name = TextEditingController();
  final description = TextEditingController();
  final phoneNumber = TextEditingController();
  final city = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (BuildContext context) => AddStoreCubit()..getCategory(),
      child: BlocConsumer<AddStoreCubit, AddStoreState>(
        builder: (context, state) {
          File? image = AddStoreCubit.get(context).addImage;
          var listCubit = AddStoreCubit.get(context);
          const Color green = Color(0xFF169956);
          return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                    size: height*0.026+width*0.017,
                    color: Colors.white
                ),
                toolbarHeight: height*0.068,
                backgroundColor: green,
                centerTitle: true,
                title:  Text(
                  'اضافة متجر ',
                  style: TextStyle(
                    fontFamily: 'Cairo',fontSize:height*0.022+width*0.013
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
                                AddStoreCubit.get(context).getImage();
                              },
                              child: Center(
                                child: ClipRRect(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image(
                                    image: image == null
                                        ? const AssetImage('images/phpto.jpg')
                                        : FileImage(image)
                                            as ImageProvider<Object>,
                                    fit: BoxFit.cover,
                                    width: width*0.88,
                                    height: constraints.maxHeight / 4,
                                  ),
                                ),
                              )
                              ),
                          const SizedBox(
                            height: 3,
                          ),
                           Text(
                            'اسم المتجر ',
                            style: TextStyle(
                              color: green,
                              fontFamily: 'Cairo',
                              fontSize: height*0.016+width*0.01,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: textFormFieldCompany(
                                width:width,
                                height: height,
                                controller: name, hintText: 'ادخل اسم المتجر '),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                           Text(
                            ' التوصيف  ',
                            style: TextStyle(
                              color: green,
                              fontFamily: 'Cairo',
                              fontSize: height*0.016+width*0.01,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: textFormFieldCompany(
                                width:width,
                                height: height,
                                controller: description,
                                hintText: 'ادخل التوصيف '),
                          ),
                           Text(
                            ' رقم الهاتف  ',
                            style: TextStyle(
                              color: green,
                              fontFamily: 'Cairo',
                              fontSize: height*0.016+width*0.01,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: textFormFieldCompany(
                                width:width,
                                controller: phoneNumber,
                                height: height,
                                hintText: 'ادخل رقم الهاتف '),
                          ),
                           Text(
                            ' المدينة  ',
                            style: TextStyle(
                              color: green,
                              fontFamily: 'Cairo',
                              fontSize: height*0.016+width*0.01,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: textFormFieldCompany(
                                width:width,
                                height: height,
                                controller: city, hintText: 'ادخل المدينة '),
                          ),
                           Text(
                            ' التصنيف ',
                            style: TextStyle(
                              color: green,
                              fontFamily: 'Cairo',
                              fontSize: height*0.016+width*0.01,
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                 color: Colors.teal, width: 2

                                ),
                                color: Colors.grey.shade100,
                                borderRadius:BorderRadius.circular(40)
                              ),
                              padding: EdgeInsets.only(left: 8,right: 8,top: height*0.002+width*0.001,bottom:height*0.002+width*0.001 ),
                              child: DropdownButton(

                                iconEnabledColor: Colors.teal,
                                hint:  Text(
                                  'اختر التصنيف ',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: height*0.015,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade900),
                                ),
                                isExpanded: true,
                                underline: const SizedBox(),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                ),
                                iconSize: height*0.03+width*0.02,
                                style:  TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Colors.black,
                                  fontSize: height*0.015+width*0.01,
                                ),
                                value: listCubit.selectItem,
                                items: listCubit.items.map((value) {
                                  return DropdownMenuItem(

                                    value: value,
                                    child: Text(
                                      value,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  listCubit.changeItemSelected(value);
                                },
                              ),
                            ),
                          ),
                         SizedBox(
                           height: height*0.03,
                         ),
                          BlocProvider(
                              create: (context) => AddLocationCubit(),
                              child: BlocConsumer<AddLocationCubit,
                                  AddLocationState>(
                                listener: (context, state) {
                                  if (state is GetLocationSuccessState) {
                                    AddStoreCubit.get(context).addStore(
                                      latitude: state.latitude,
                                      longitude: state.longitude,
                                      name: name.text,
                                      description: description.text,
                                      phoneNumber: phoneNumber.text,
                                      city: city.text,
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  AddLocationCubit add =
                                      AddLocationCubit.get(context);
                                  return ConditionalBuilder(
                                      condition:
                                          state is! GetLocationLoadingState,
                                      builder: (context) => Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                              width: constraints.maxWidth * 0.4,
                                              height: height*0.05,
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                  add.getLocation();
                                                },
                                                icon:  Icon(Icons.add,size:height*0.017+width*0.01),
                                                label: const Text(
                                                  'اضافة',
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo'),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: green,
                                                  textStyle:  TextStyle(
                                                    fontSize: height*0.017+width*0.01,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      fallback: (context) => const Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      green),
                                            ),
                                          ));
                                },
                              ))
                        ],
                      ),
                    ),
                  );
                },
              ));
        },
        listener: (context, state) {
          if (state is SuccessState) {
            flutterToast(state.model.message ?? '', "success");
          }
        },
      ),
    );
  }
}
