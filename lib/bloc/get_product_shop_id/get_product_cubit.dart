import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../component/helper.dart';
import '../../model/change_favorite_model.dart';
import '../../model/product/get_product_by_shop.dart';
import '../../model/store/add_store.dart';
import '../../network/local/cache.dart';
import '../../network/remote/http.dart';
import 'get_product_state.dart';
import 'package:http/http.dart' as http;

class GetProductCubit extends Cubit<GetProductByShopState> {
  GetProductCubit() : super(GetProductByShopInitialState());

  static GetProductCubit get(context) => BlocProvider.of(context);
  GetProductModel? getProductModel;

  Map<dynamic, dynamic> favourites = {};
  ChangeFavoritesModel? changeFavoritesModel;

  AddProductModel? addModel;

  Future deleteProduct({required id}) async {
    emit(DeleteProductLoadingState());

    await HttpHelper.deleteData(
      url: "deleteProduct/$id",
    ).then((value) {
      addModel = AddProductModel.fromJson(jsonDecode(value.body));
      emit(DeleteProductSuccessState(addModel!));
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(DeleteProductErrorState());
    });
  }

  Future openCloseShop({required id}) async {
    emit(OpenCloseLoadingState());

    await HttpHelper.postData(
      url: "open_closeShop",
      data: {"shop_id": id.toString()},
    ).then((value) {
      addModel = AddProductModel.fromJson(jsonDecode(value.body));

      emit(OpenCloseSuccessState(addModel!));
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(OpenCloseErrorState());
    });
  }

  Future getProductByShopId({required id, name, price, photo, shopId}) async {
    emit(LoadingState());

    await HttpHelper.getData(
      url: "getProductsByShop/$id",
    ).then((value) {
      getProductModel = GetProductModel.fromJson(jsonDecode(value.body));

      getProductModel?.productsData?.forEach((element) {
        favourites.addAll({
          element.id: element.inFavorite,
        });
      });

      emit(SuccessState(getProductModel));
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(ErrorState());
    });
  }

  Future changeFavourite({required id}) async {
    if (favourites[id] == 1) {
      favourites[id] = 0;
    } else {
      favourites[id] = 1;
    }
    emit(ChangeFavouriteState());

    await HttpHelper.postData(
      url: "addProductToFavorite/$id",
      data: null,
    ).then((value) {
      changeFavoritesModel =
          ChangeFavoritesModel.fromJson(jsonDecode(value.body));

      emit(SuccessChangeFavouriteState(changeFavoritesModel!));
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(ErrorFavoriteState());
    });
  }

  Future addProduct({
    required name,
    required description,
    required price,
    required quantity,
    required shopId,
  }) async {
    emit(AddProductLoadingState());
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${EndPoint.url}addProduct'),
    );
    request.headers['Authorization'] =
        'Bearer ${CacheHelper.getData(key: 'token')}';
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['price'] = price;
    request.fields['weight'] = '200';
    request.fields['quantity'] = quantity;
    request.fields['brand_name'] = "Dell";
    request.fields['shop_id'] = shopId.toString();
    request.fields['colors[0]'] = 'Black';
    if (addImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath('photos[0]', addImage!.path),
      );
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((value) {
        addModel = AddProductModel.fromJson(jsonDecode(value));
        emit(AddProductSuccessState(addModel!));
      }).onError((handleError) {
        if (kDebugMode) {
          print(handleError.toString());
        }
      });
    }
  }

  File? addImage;
  var addPicker = ImagePicker();

  Future getImage() async {
    final pikedFile = await addPicker.pickImage(source: ImageSource.gallery);
    if (pikedFile != null) {
      addImage = File(pikedFile.path);
      emit(AddProductImageSuccess());
    } else {
      emit(AddProductImageError());
    }
  }
}
