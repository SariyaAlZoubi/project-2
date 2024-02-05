class GetFavoriteModel {
  List<FavoriteProductsData>? favoriteProductsData;

  GetFavoriteModel({this.favoriteProductsData});

  GetFavoriteModel.fromJson(Map<String, dynamic> json) {
    if (json['favoriteProductsData'] != null) {
      favoriteProductsData = <FavoriteProductsData>[];
      json['favoriteProductsData'].forEach((v) {
        favoriteProductsData!.add(FavoriteProductsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (favoriteProductsData != null) {
      data['favoriteProductsData'] =
          favoriteProductsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavoriteProductsData {
  int? productId;
  String? price;
  String? name;
  String? picture;
  String? description;

  FavoriteProductsData(
      {this.productId, this.price, this.name, this.picture, this.description});

  FavoriteProductsData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    price = json['price'];
    name = json['name'];
    picture = json['picture'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['price'] = price;
    data['name'] = name;
    data['picture'] = picture;
    data['description'] = description;
    return data;
  }
}
