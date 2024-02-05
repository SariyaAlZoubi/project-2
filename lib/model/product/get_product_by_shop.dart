import '../../network/local/cache.dart';

class GetProductModel {
  List<ProductsData>? productsData;

  GetProductModel({this.productsData});

  GetProductModel.fromJson(Map<String, dynamic> json) {
    if (json['productsData'] != null) {
      productsData = <ProductsData>[];
      json['productsData'].forEach((v) {
        productsData!.add(ProductsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productsData != null) {
      data['productsData'] = productsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductsData {
  int? id;
  String? name;
  int? quantity;
  String? price;
  String? picture;
  int? inFavorite;

  ProductsData({
    this.id,
    this.name,
    this.quantity,
    this.price,
    this.picture,
    this.inFavorite,
  });

  ProductsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    picture = json['picture'];
    if (CacheHelper.getData(key: 'type') == 'customer') {
      inFavorite = json['in_favorite'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    data['picture'] = picture;
    data['in_favorite'] = inFavorite;
    return data;
  }
}
