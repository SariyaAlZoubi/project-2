class OrdersModel {
  List<OrdersInfo>? ordersInfo;

  OrdersModel({this.ordersInfo});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['orders_info'] != null) {
      ordersInfo = <OrdersInfo>[];
      json['orders_info'].forEach((v) {
        ordersInfo!.add(OrdersInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ordersInfo != null) {
      data['orders_info'] = ordersInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrdersInfo {
  int? id;
  String? orderState;
  String? date;
  CustomerLocation? customerLocation;
  String? customerName;
  String? customerNumber;
  String? image;

  OrdersInfo({this.id, this.orderState, this.date, this.image});

  OrdersInfo.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      id = json['id'];
    }
    if (json['order_id'] != null) {
      id = json['order_id'];
    }
    if (json['customer_name'] != null) {
      customerName = json['customer_name'];
    }
    if (json['customer_phone'] != null) {
      customerNumber = json['customer_phone'];
    }
    orderState = json['order_state'];
    date = json['date'];
    image = json['order_image'];
    customerLocation = json['customer_location'] != null
        ? CustomerLocation.fromJson(json['customer_location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_state'] = orderState;
    data['date'] = date;
    if (customerLocation != null) {
      data['customer_location'] = customerLocation!.toJson();
    }
    if (customerNumber != null) {
      data['customer_phone'] = customerNumber;
    }
    if (customerName != null) {
      data['customer_name'] = customerName;
    }
    data['image'] = image;
    return data;
  }
}

class CustomerLocation {
  int? id;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;

  CustomerLocation(
      {this.id, this.latitude, this.longitude, this.createdAt, this.updatedAt});

  CustomerLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
