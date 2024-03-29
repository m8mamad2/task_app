import 'package:taskapp/src/view/data/model/user_model.dart';

class AuthResModel {
  bool? success;
  String? message;
  UserModel? user;

  AuthResModel({this.success, this.message, this.user});

  AuthResModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}