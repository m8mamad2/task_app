// import 'package:dio/dio.dart';
import 'package:taskapp/src/view/data/model/auth_req_model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/api.dart';

class AuthApiCall{
    
  Api api = Api.instace;
  Future<http.Response> loginApi (LoginModel data) async =>  await api.post('auth/login',  data.toJson());
  Future<http.Response> signupApi(SignupModel data) async => await api.post('auth/signup', data.toJson());
  
}