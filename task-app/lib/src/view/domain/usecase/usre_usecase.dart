import 'package:taskapp/src/view/data/model/user_model_localy.dart';
import 'package:taskapp/src/view/domain/repo/user_repo_header.dart';

class UserUsecase {
  UserRepoHeader repo;
  UserUsecase(this.repo);
  
  Future<Map<String,bool>> addUserToDB()=> repo.addUserToDB();
  Future<UserModelLocaly?> getUser()=> repo.getUser();
  Future<bool> updateUserName(String name)=> repo.updateUserName(name);
  Future<bool> updateProfileAvatar(int profileId)=> repo.updateProfileAvatar(profileId);
  Future<bool> deleteAccount()=> repo.deleteAccount();
  Future logOutUser()=> repo.logOutUser();
}