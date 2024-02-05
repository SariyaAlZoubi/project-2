class OrderDetailsModel {
  OrderDetail? orderDetail;

  OrderDetailsModel({this.orderDetail});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    orderDetail = json['orderDetail'] != null
        ? OrderDetail.fromJson(json['orderDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderDetail != null) {
      data['orderDetail'] = orderDetail!.toJson();
    }
    return data;
  }
}

class OrderDetail {
  int? orderId;
  List<OrderItems>? orderItems;
  String? totalPrice;
  String? orderState;
  String? deliveryValue;
  int? total;

  OrderDetail(
      {this.orderId,
      this.orderItems,
      this.totalPrice,
      this.orderState,
      this.deliveryValue,
      this.total});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
    totalPrice = json['total_price'];
    orderState = json['order_state'];
    deliveryValue = json['delivery_value'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    data['total_price'] = totalPrice;
    data['order_state'] = orderState;
    data['delivery_value'] = deliveryValue;
    data['Total'] = total;
    return data;
  }
}

class OrderItems {
  int? shopId;
  int? productId;
  String? productName;
  String? productDescription;
  String? productPrice;
  String? image;
  int? quantity;
  String? shopName;
  int? itemPrice;

  OrderItems(
      {this.shopId,
      this.productId,
      this.productName,
      this.shopName,
      this.productDescription,
      this.productPrice,
      this.image,
      this.quantity,
      this.itemPrice});

  OrderItems.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    if (json['name'] != null) {
      shopName = json['name'];
    }
    productId = json['product_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    quantity = json['quantity'];
    itemPrice = json['item_price'];
    image = json['product_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shop_id'] = shopId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_description'] = productDescription;
    data['product_price'] = productPrice;
    data['quantity'] = quantity;
    data['item_price'] = itemPrice;
    data['product_photo'] = image;
    return data;
  }
}
