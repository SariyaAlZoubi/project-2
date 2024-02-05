class SearchProductModel {
  List<ProductsData>? productsData;

  SearchProductModel({this.productsData});

  SearchProductModel.fromJson(Map<String, dynamic> json) {
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
  String? description;
  String? picture;
  int? inFavorite;

  ProductsData({
    this.id,
    this.name,
    this.price,
    this.description,
    this.picture,
    this.inFavorite,
  });

  ProductsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    picture = json['picture'];
    inFavorite = json['in_favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['picture'] = picture;
    data['in_favorite'] = inFavorite;
    return data;
  }
}
