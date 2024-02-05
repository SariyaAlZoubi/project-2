class RegisterModel {
  bool? status;
  String? message;
  Data? data;
  String? token;

  RegisterModel({this.status, this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    if (json['status'] != null) {
      status = json['status'];
    }
    if (json['message'] != null) {
      message = json['message'];
    }
    if (json['token'] != null) {
      token = json['token'];
    }
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status;
    }
    if (message != null) {
      data['message'] = message;
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? phoneNumber;
  int? id;

  Data({this.name, this.phoneNumber, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone_number'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['id'] = id;
    return data;
  }
}
