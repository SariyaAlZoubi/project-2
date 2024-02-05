class GetStoreModel {
  List<ShopsData>? shopsData;

  GetStoreModel({this.shopsData});

  GetStoreModel.fromJson(Map<String, dynamic> json) {
    if (json['shopsData'] != null) {
      shopsData = <ShopsData>[];
      json['shopsData'].forEach((v) {
        shopsData!.add(ShopsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shopsData != null) {
      data['shopsData'] = shopsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopsData {
  int? id;
  String? name;
  String? description;
  String? phoneNumber;
  String? photo;
  int? isOpen;
  Location? location;
  int? shopState;
  int? avgStars;
  int? inFavorite;

  ShopsData(
      {this.id,
      this.location,
      this.name,
      this.description,
      this.phoneNumber,
      this.photo,
      this.isOpen,
      this.shopState,
      this.avgStars,
      this.inFavorite});

  ShopsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    phoneNumber = json['phone_number'];
    photo = json['photo'];
    isOpen = json['is_open'];
    shopState = json['shop_state'];
    avgStars = json['avg_stars'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    inFavorite = json['in_favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['phone_number'] = phoneNumber;
    data['photo'] = photo;
    data['is_open'] = isOpen;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['shop_state'] = shopState;
    data['avg_stars'] = avgStars;
    data['in_favorite'] = inFavorite;
    return data;
  }
}

class Location {
  int? id;
  String? city;

  Location({
    this.id,
    this.city,
  });

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city'] = city;
    return data;
  }
}
