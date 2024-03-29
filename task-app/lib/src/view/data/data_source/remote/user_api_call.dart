// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/api.dart';

class UserApiCall{
    
  Api api = Api.instace;

  Future<http.Response> getUserApi ()  async =>  await api.get('user/getUser');
  Future<http.Response> updateProfileAvaterApi(int profileId) async => await api.put('user/updateProfile', { "profileId":profileId });
  Future<http.Response> updateNameApi(String name) async => await api.put('user/updateUserName', {"name":name});
  Future<http.Response> deleteAcoountApi() async => await api.delete('user/deleteAccount');

}