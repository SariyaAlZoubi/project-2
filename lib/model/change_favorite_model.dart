class ChangeFavoritesModel {
  String? message;
  bool? status;

  ChangeFavoritesModel({this.message, this.status});

  ChangeFavoritesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
