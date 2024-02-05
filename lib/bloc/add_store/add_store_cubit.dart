import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../component/helper.dart';
import '../../model/category/get_category.dart';
import '../../model/store/add_store.dart';
import '../../network/local/cache.dart';
import '../../network/remote/http.dart';
import 'add_store_state.dart';
import 'package:http/http.dart' as http;

class AddStoreCubit extends Cubit<AddStoreState> {
  AddStoreCubit() : super(AddStoreInitialState());

  static AddStoreCubit get(context) => BlocProvider.of(context);
  String? selectItem;
  var items = [
    'food',
    'electric',
  ];
  CategoryModel? getCategoryModel;

  void getCategory() {
    emit(Loading());
    HttpHelper.getData(
      url: "getAllCategories",
    ).then((value) {
      var responseData = jsonDecode(value.body);
      var categoryList = responseData['categories'] as List<dynamic>;
      var categories = categoryList
          .map((category) => Categories.fromJson(category))
          .toList();
      items = categories.map((category) => category.name!).toList();

      getCategoryModel = CategoryModel.fromJson(jsonDecode(value.body));

      emit(Success());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(Error());
    });
  }

  AddProductModel? addStoreModel;

  int categoryId = 0;

  Future addStore({
    required name,
    required description,
    required phoneNumber,
    required city,
    required longitude,
    required latitude,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${EndPoint.url}addShopWithLocation'),
    );
    request.headers['Authorization'] =
        'Bearer ${CacheHelper.getData(key: 'token')}';
    if (selectItem == 'أغذية ') {
      categoryId = 1;
    } else if (selectItem == 'ألبسة') {
      categoryId = 2;
    } else {
      categoryId = 3;
    }
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['phone_number'] = phoneNumber;
    request.fields['city'] = city;
    request.fields['latitude'] = '$latitude';
    request.fields['longitude'] = '$longitude';
    request.fields['category_id'] = categoryId.toString();
    if (addImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath('photo', addImage!.path),
      );
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((value) {
        addStoreModel = AddProductModel.fromJson(jsonDecode(value));

        emit(SuccessState(addStoreModel!));
      });
    }
  }

  void changeItemSelected(value) {
    selectItem = value;
    emit(DropList());
  }

  File? addImage;
  var addPicker = ImagePicker();

  Future getImage() async {
    final pikedFile = await addPicker.pickImage(source: ImageSource.gallery);
    if (pikedFile != null) {
      addImage = File(pikedFile.path);
      emit(ImageSuccess());
    } else {
      emit(ImageError());
    }
  }
}
