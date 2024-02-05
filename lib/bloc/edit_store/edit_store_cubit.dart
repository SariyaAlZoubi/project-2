import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/component/helper.dart';
import '../../model/store/add_store.dart';
import '../../model/store/get_shop_info.dart';
import '../../network/local/cache.dart';
import '../../network/remote/http.dart';
import 'edit_store_state.dart';
import 'package:http/http.dart' as http;

class EditStoreCubit extends Cubit<EditStoreState> {
  EditStoreCubit() : super(EditStoreInitialState());

  AddProductModel? addModel;

  static EditStoreCubit get(context) => BlocProvider.of(context);

  GetShopInfoModel? getShopInfoModel;

  Future getShopInfo({required id}) async {
    emit(LoadingState());
    await HttpHelper.getData(
      url: "getshopinfo/$id",
    ).then((value) {
      getShopInfoModel = GetShopInfoModel.fromJson(jsonDecode(value.body));

      emit(SuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(ErrorState());
    });
  }

  void editStore({
    required name,
    required description,
    required phoneNumber,
    required city,
    required shopId,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${EndPoint.url}/updateShopWithLocation'),
    );

    request.headers['Authorization'] =
        'Bearer ${CacheHelper.getData(key: 'token')}';

    request.fields['shop_id'] = shopId.toString();
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['phone_number'] = phoneNumber;
    request.fields['city'] = city;
    request.fields['latitude'] = '33.5138';
    request.fields['longitude'] = '33.5138';
    if (addImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath('photo', addImage!.path),
      );
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((value) {
        addModel = AddProductModel.fromJson(jsonDecode(value));
        emit(EditStoreSuccessState(addModel!));
      });
    }
  }

  File? addImage;
  var addPicker = ImagePicker();

  Future getImage() async {
    final pikedFile = await addPicker.pickImage(source: ImageSource.gallery);
    if (pikedFile != null) {
      addImage = File(pikedFile.path);
      emit(EditStoreImageSuccessState());
    } else {
      emit(EditStoreImageErrorState());
    }
  }
}
