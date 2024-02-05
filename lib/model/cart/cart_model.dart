class CartModel {
  String? message;

  List<CartItems>? cartItems;
  var totalPrice;
  var deliveryValue;
  var total;

  CartModel(
      {this.cartItems,
      this.totalPrice,
      this.deliveryValue,
      this.total,
      this.message});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
    if (json['total_price'] != null) {
      totalPrice = json['total_price'];
    }
    if (json['delivery_value'] != null) {
      deliveryValue = json['delivery_value'];
    }
    if (json['Total'] != null) {
      total = json['Total'];
    }
    if (json['message'] != null) {
      message = json['message'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cartItems != null) {
      data['cart_items'] = cartItems!.map((v) => v.toJson()).toList();
    }
    data['total_price'] = totalPrice;
    data['delivery_value'] = deliveryValue;
    data['Total'] = total;
    return data;
  }
}

class CartItems {
  int? productId;
  String? productName;
  String? productPhoto;
  String? productDescription;
  String? productPrice;
  int? quantity;
  int? itemPrice;
  int? totalQuantity;

  CartItems(
      {this.productId,
      this.totalQuantity,
      this.productName,
      this.productPhoto,
      this.productDescription,
      this.productPrice,
      this.quantity,
      this.itemPrice});

  CartItems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    totalQuantity = json['quantitys'];
    productName = json['product_name'];
    productPhoto = json['product_photo'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    quantity = json['quantity'];
    itemPrice = json['item_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_photo'] = productPhoto;
    data['product_description'] = productDescription;
    data['product_price'] = productPrice;
    data['quantity'] = quantity;
    data['item_price'] = itemPrice;
    return data;
  }
}
