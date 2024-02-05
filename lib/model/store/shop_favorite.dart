class FavoriteStoreModel {
  List<FavoriteShopData>? favoriteShopData;

  FavoriteStoreModel({this.favoriteShopData});

  FavoriteStoreModel.fromJson(Map<String, dynamic> json) {
    if (json['favoriteShopData'] != null) {
      favoriteShopData = <FavoriteShopData>[];
      json['favoriteShopData'].forEach((v) {
        favoriteShopData!.add(FavoriteShopData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (favoriteShopData != null) {
      data['favoriteShopData'] =
          favoriteShopData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavoriteShopData {
  int? isOpen;
  Location? location;
  int? shopId;
  String? name;
  String? photo;
  String? description;

  FavoriteShopData(
      {this.isOpen,
      this.location,
      this.shopId,
      this.name,
      this.photo,
      this.description});

  FavoriteShopData.fromJson(Map<String, dynamic> json) {
    isOpen = json['is_open'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    shopId = json['shop_id'];
    name = json['name'];
    photo = json['photo'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_open'] = isOpen;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['shop_id'] = shopId;
    data['name'] = name;
    data['photo'] = photo;
    data['description'] = description;
    return data;
  }
}

class Location {
  String? city;

  Location({this.city});

  Location.fromJson(Map<String, dynamic> json) {
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    return data;
  }
}
