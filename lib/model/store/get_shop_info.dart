class GetShopInfoModel {
  ShopData? shopData;

  GetShopInfoModel({this.shopData});

  GetShopInfoModel.fromJson(Map<String, dynamic> json) {
    shopData =
        json['shopData'] != null ? ShopData.fromJson(json['shopData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shopData != null) {
      data['shopData'] = shopData!.toJson();
    }
    return data;
  }
}

class ShopData {
  String? name;
  String? description;
  String? phoneNumber;
  String? photo;
  int? isOpen;
  int? shopState;
  Location? location;
  Vendor? vendor;
  String? avgStars;

  ShopData(
      {this.name,
      this.description,
      this.phoneNumber,
      this.photo,
      this.isOpen,
      this.shopState,
      this.location,
      this.vendor,
      this.avgStars});

  ShopData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    phoneNumber = json['phone_number'];
    photo = json['photo'];
    isOpen = json['is_open'];
    shopState = json['shop_state'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    vendor = json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    avgStars = json['avg_stars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['avg_stars'] = avgStars;
    return data;
  }
}

class Location {
  int? id;
  String? street;
  String? city;
  String? building;
  String? floor;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;

  Location(
      {this.id,
      this.street,
      this.city,
      this.building,
      this.floor,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    street = json['street'];
    city = json['city'];
    building = json['building'];
    floor = json['floor'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['street'] = street;
    data['city'] = city;
    data['building'] = building;
    data['floor'] = floor;
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
