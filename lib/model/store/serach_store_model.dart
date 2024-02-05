class SearchStoreModel {
  List<ShopsData>? shopsData;

  SearchStoreModel({this.shopsData});

  SearchStoreModel.fromJson(Map<String, dynamic> json) {
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
  int? shopState;
  Location? location;
  Vendor? vendor;
  int? inFavorite;

  ShopsData({
    this.id,
    this.name,
    this.description,
    this.phoneNumber,
    this.photo,
    this.isOpen,
    this.shopState,
    this.location,
    this.vendor,
    this.inFavorite,
  });

  ShopsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    phoneNumber = json['phone_number'];
    photo = json['photo'];
    isOpen = json['is_open'];
    shopState = json['shop_state'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    vendor = json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    inFavorite = json['in_favorite'];
    //  avgStars = json['avg_stars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;

    data['name'] = name;
    data['description'] = description;
    data['phone_number'] = phoneNumber;
    data['photo'] = photo;
    data['is_open'] = isOpen;
    data['shop_state'] = shopState;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    data['in_favorite'] = inFavorite;
    return data;
  }
}

class Location {
  int? id;
  String? city;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;

  Location(
      {this.id,
      this.city,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city'] = city;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Vendor {
  int? id;
  String? phoneNumber;
  String? password;
  String? createdAt;
  String? updatedAt;

  Vendor(
      {this.id,
      this.phoneNumber,
      this.password,
      this.createdAt,
      this.updatedAt});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phone_number'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone_number'] = phoneNumber;
    data['password'] = password;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
