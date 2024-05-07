
// import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:taskapp/src/view/data/data_source/local/loacl_db.dart';

class Api{
  static final Api instace = Api._();
  Api._();

  // final String baseUri = 'https://73df-188-122-106-247.ngrok-free.app/api/';
  final String baseUri = 'http://localhost:8001/api/';
  final Map<String,String> baseHeader = { "Content-Type" : "application/json" };
  Future<String?> getToken()async => boxList[1].values.firstOrNull;

  Future<http.Response> post(String endpoint,Object data)async{

    String url = (baseUri+endpoint).trim();
    
    String? token = await getToken();
    if(token != null && token.isNotEmpty) baseHeader.addAll({'Authorization':'Bearer $token'});
    
    return await http.post(
      Uri.parse(url),
      headers: baseHeader,
      body: json.encode(data) );
  }
  
  Future<http.Response> get(String endpoint)async{
    String url = (baseUri+endpoint).trim();
    String? token = await getToken();
    if(token != null && token.isNotEmpty) baseHeader.addAll({'Authorization':'Bearer $token'});
    return await http.get( Uri.parse(url), headers: baseHeader, );
  }
  
  Future<http.Response> put(String endpoint,Object data)async{
    String url = (baseUri+endpoint).trim();
    String? token = await getToken();
    if(token != null && token.isNotEmpty) baseHeader.addAll({'Authorization':'Bearer $token'});
    return await http.put(
      Uri.parse(url),
      headers: baseHeader,
      body: json.encode(data) );
  }
  
  Future<http.Response> delete(String endpoint,[Object? data])async{
    String url = (baseUri+endpoint).trim();
    String? token = await getToken();
    if(token != null && token.isNotEmpty) baseHeader.addAll({'Authorization':'Bearer $token'});
    return await http.delete( Uri.parse(url), headers: baseHeader,body: data);
  }
  
}


