import 'dart:convert';

import 'package:taskapp/src/view/data/data_source/local/loacl_db.dart';
import 'package:taskapp/src/view/data/data_source/remote/user_api_call.dart';
import 'package:taskapp/src/view/data/model/user_model.dart';
import 'package:taskapp/src/view/data/model/user_model_localy.dart';
import 'package:taskapp/src/view/domain/repo/user_repo_header.dart';
import 'package:http/http.dart' as http;


//! data.token!.substring(0,10) ----> for key DB

class UserRepoBody extends UserRepoHeader{
  UserApiCall api;
  UserRepoBody(this.api);
  
  @override
  Future<Map<String,bool>> addUserToDB() async{
    final http.Response res = await api.getUserApi();
    if(res.statusCode == 200){
      final UserModel data = UserModel.fromJson(json.decode(res.body));

      final UserModelLocaly localData = UserModelLocaly.fromUserModel(data);
      await boxList[2].clear();
      await boxList[2].put(data.token!.substring(0,10), localData);
      return { 'ok' : true };
    }
    return { '${res.statusCode}' : false };
  }

  @override
  Future<UserModelLocaly?> getUser()async=> await boxList[2].values.firstOrNull as UserModelLocaly?;
  
  @override
  Future<bool> updateUserName(String name) async{
    final http.Response res = await api.updateNameApi(name);
    if(res.statusCode == 200) {
      await addUserToDB();
      return true;
    }
    return false;
  }

  @override
  Future<bool> updateProfileAvatar(int profileId) async{
    final http.Response res = await api.updateProfileAvaterApi(profileId);
    if(res.statusCode == 200) {
      await addUserToDB();
      return true;
    }
    return false;
  }
  
  @override
  Future<bool> deleteAccount()async{
    final http.Response res = await api.deleteAcoountApi();
    if(res.statusCode == 200) return true;
    return false;
  }

  @override
  Future logOutUser()async {
    await boxList[1].clear();
    await boxList[2].clear();
  }

}