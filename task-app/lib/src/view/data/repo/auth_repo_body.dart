import 'dart:convert';

import 'package:taskapp/src/view/data/data_source/remote/auth_api_call.dart';
import 'package:taskapp/src/view/data/data_source/local/loacl_db.dart';
import 'package:taskapp/src/view/data/model/auth_req_model.dart';
import 'package:taskapp/src/view/data/model/auth_res_model.dart';
import 'package:taskapp/src/view/data/model/user_model_localy.dart';
import 'package:taskapp/src/view/domain/repo/auth_repo_header.dart';
import 'package:http/http.dart' as http;

class AuthRepoBody extends AuthRepoHeader{
  AuthApiCall api;
  AuthRepoBody(this.api);

  @override
  Future<Map<String,bool>> login(LoginModel data) async{
    final http.Response res = await api.loginApi(data);
    if(res.statusCode == 200){
      try{
        final AuthResModel data = AuthResModel.fromJson(json.decode(res.body));
        if(data.user?.token != null && data.user!.token!.isNotEmpty){
          
          //* Token
          await boxList[1].clear();
          await boxList[1].put('token', data.user!.token);

          //* save User Localy
          final UserModelLocaly localData = UserModelLocaly.fromUserModel(data.user!);
          await boxList[2].put(localData.token!.substring(0,10), localData);

          
          return { 'Token Created': true };
        }
        else{
          return { 'token is Not Currect': false};
        }
      }
      catch(e){
        return { '$e': false};
      }
    }
    return { '${res.statusCode}': false };
  }

  @override
  Future<Map<String,bool>> signup(SignupModel data)async {
    final http.Response res = await api.signupApi(data);
    if(res.statusCode == 200) {
      try{
        final AuthResModel data = AuthResModel.fromJson(json.decode(res.body));
        if(data.user?.token != null && data.user!.token!.isNotEmpty){

          //* Token
          await boxList[1].clear();
          await boxList[1].put('token', data.user!.token);

          //* User Localy
          final UserModelLocaly localData = UserModelLocaly.fromUserModel(data.user!);
          await boxList[2].put(localData.token!.substring(0,10), localData);

          
          return { 'Token Created': true };
        }
        else{
          return { 'token is Not Currect': false};
        }
      }
      catch(e){
        return { '$e': false};
      }
    }
    return { 'result=${res.statusCode};': false };
   }

  @override
  Future forgotPassword() => Future.value(true);

}