class VerifyModel {
  String? message;

  String? token;

  VerifyModel({this.message, this.token});

  VerifyModel.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = json['message'];
    }
    if (json['token'] != null) {
      token = json['token'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (message != null) {
      data['message'] = message;
    }
    if (token != null) {
      data['token'] = token;
    }
    return data;
  }
}
