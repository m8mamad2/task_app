import 'package:taskapp/src/view/data/model/user_model_localy.dart';

abstract class UserRepoHeader{
  Future<UserModelLocaly?> getUser();
  Future<Map<String,bool>> addUserToDB();
  Future<bool> updateUserName(String name);
  Future<bool> updateProfileAvatar(int profileId);
  Future<bool> deleteAccount();
  Future logOutUser();
}