import 'package:taskapp/src/view/data/model/auth_req_model.dart';

abstract class AuthRepoHeader{
  Future<Map<String,bool>> signup(SignupModel data);
  Future<Map<String,bool>> login(LoginModel data);
  Future forgotPassword();
} 