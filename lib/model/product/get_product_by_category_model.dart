class GetProductByCategoryModel {
  List<ProductsData>? productsData;

  GetProductByCategoryModel({this.productsData});

  GetProductByCategoryModel.fromJson(Map<String, dynamic> json) {
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
  String? price;
  String? picture;
  String? shopName;
  int? inFavorite;
  String? date;

  ProductsData(
      {this.id,
      this.name,
      this.price,
      this.picture,
      this.shopName,
      this.inFavorite,
      this.date});

  ProductsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    picture = json['picture'];
    shopName = json['shop_name'];
    inFavorite = json['in_favorite'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['picture'] = picture;
    data['shop_name'] = shopName;
    data['in_favorite'] = inFavorite;
    data['date'] = date;
    return data;
  }
}
