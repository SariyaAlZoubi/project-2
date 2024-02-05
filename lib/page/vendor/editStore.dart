

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/model/store/get_shop_info.dart';
import '../../bloc/edit_store/edit_store_cubit.dart';
import '../../bloc/edit_store/edit_store_state.dart';
import '../../component/helper.dart';
import '../../component/textfield.dart';

class EditStore extends StatelessWidget {
  final int id;

 const EditStore({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => EditStoreCubit()..getShopInfo(id: id),
      child: BlocConsumer<EditStoreCubit, EditStoreState>(
        listener: (context, state) {
          if (state is EditStoreSuccessState) {
            flutterToast(state.model.message.toString(), "success");
          }
        },
        builder: (context, state) {
          GetShopInfoModel? getShopModel =
              EditStoreCubit.get(context).getShopInfoModel;

          File? image = EditStoreCubit.get(context).addImage;
          final name = TextEditingController();
          name.text = getShopModel?.shopData?.name ?? '';
          final description = TextEditingController();
          description.text = getShopModel?.shopData?.description ?? '';
          final phoneNumber = TextEditingController();
          phoneNumber.text = getShopModel?.shopData?.phoneNumber ?? '';

          final city = TextEditingController();
          city.text = getShopModel?.shopData?.location?.city ?? '';

          const Color green = Color(0xFF169956);

          return getShopModel != null
              ? Scaffold(
                backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: green,
                    centerTitle: true,
                    iconTheme: IconThemeData(
                        size: height*0.026+width*0.017,
                        color: Colors.white
                    ),
                    toolbarHeight: height*0.068,
                    title:  Text('تعديل المحل',  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize:height*0.022+width*0.013,
                    )),
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
                                    EditStoreCubit.get(context).getImage();
                                  },
                                  child: Image(
                                    image: image == null
                                        ? NetworkImage(
                                            EndPoint.imageShopUrl +
                                                (getShopModel.shopData?.photo ??
                                                    'sd'),
                                          )
                                        : FileImage(image)
                                            as ImageProvider<Object>,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: constraints.maxHeight / 3,
                                  )),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
                                'اسم المتجر ',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16,
                                  color: green
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: textFormFieldCompany(
                                    height: height,
                                    width: width,
                                    controller: name,
                                    hintText: 'ادخل اسم المتجر '),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
                                'ادخل التوصيف  ',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16,
                                  color: green
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: textFormFieldCompany(
                                  height: height,
                                    width: width,
                                    controller: description,
                                    hintText: 'ادخل التوصيف '),
                              ),
                              const Text(
                                'ادخل رقم الهاتف  ',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16,
                                  color: green
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: textFormFieldCompany(
                                    height: height,
                                    width: width,
                                    controller: phoneNumber,
                                    hintText: 'ادخل رقم الهاتف '),
                              ),
                              const Text(
                                'ادخل المدينة  ',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16,
                                    color: green
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: textFormFieldCompany(
                                    height: height,
                                    width: width,
                                    controller: city,
                                    hintText: 'ادخل المدينة '),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: constraints.maxWidth * 0.4,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      EditStoreCubit.get(context).editStore(
                                        name: name.text,
                                        description: description.text,
                                        phoneNumber: phoneNumber.text,
                                        city: city.text,
                                        shopId: id,
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                    label: const Text(
                                      'تعديل',
                                      style: TextStyle(fontFamily: 'Cairo'),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: green,
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
