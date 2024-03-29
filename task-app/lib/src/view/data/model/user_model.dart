class UserModel {
  String? name;
  String? email;
  String? token;
  int? profileImage;

  UserModel({this.name, this.email, this.profileImage});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    token = json['token'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['token'] = token;
    data['profile_image'] = profileImage;
    return data;
  }

}
