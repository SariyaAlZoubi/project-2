class MapModel {
  String? customerName;
  CustomerLocation? customerLocation;
  List<ShopNameAndLocation>? shopNameAndLocation;

  MapModel(
      {this.customerName, this.customerLocation, this.shopNameAndLocation});

  MapModel.fromJson(Map<String, dynamic> json) {
    customerName = json['customer_name'];
    customerLocation = json['customer_location'] != null
        ? CustomerLocation.fromJson(json['customer_location'])
        : null;
    if (json['shop_name_and_location'] != null) {
      shopNameAndLocation = <ShopNameAndLocation>[];
      json['shop_name_and_location'].forEach((v) {
        shopNameAndLocation!.add(ShopNameAndLocation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_name'] = customerName;
    if (customerLocation != null) {
      data['customer_location'] = customerLocation!.toJson();
    }
    if (shopNameAndLocation != null) {
      data['shop_name_and_location'] =
          shopNameAndLocation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerLocation {
  int? id;
  String? city;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;

  CustomerLocation(
      {this.id,
      this.city,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt});

  CustomerLocation.fromJson(Map<String, dynamic> json) {
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

class ShopNameAndLocation {
  String? name;
  String? latitude;
  String? longitude;

  ShopNameAndLocation({this.name, this.latitude, this.longitude});

  ShopNameAndLocation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
