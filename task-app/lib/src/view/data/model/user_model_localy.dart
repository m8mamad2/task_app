

import 'package:hive/hive.dart';
import 'package:taskapp/src/view/data/model/user_model.dart';

part 'user_model_localy.g.dart';

@HiveType(typeId: 1)
class UserModelLocaly {

  @HiveField(0)
  final String? name;

  @HiveField(1)
  final String? email;
  
  @HiveField(2)
  final String? token;
  
  @HiveField(3)
  final int? profileImage;

  UserModelLocaly({this.name, this.email, this.profileImage,this.token});

  factory UserModelLocaly.fromUserModel(UserModel userModel)=> UserModelLocaly(
    email:userModel.email ,
    name:userModel.name ,
    profileImage:userModel.profileImage ,
    token:userModel.token 
  );
  
}
