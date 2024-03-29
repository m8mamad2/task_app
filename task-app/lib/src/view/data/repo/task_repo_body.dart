import 'dart:convert';
import 'dart:developer';

import 'package:taskapp/src/view/data/data_source/remote/task_api_call.dart';
import 'package:taskapp/src/view/data/model/task_model.dart';
import 'package:taskapp/src/view/domain/repo/task_repo_header.dart';
import 'package:http/http.dart' as http;

class TaskRepoBody extends TaskRepoHeader{
  TaskApiCall api;
  TaskRepoBody(this.api);
  
  @override
  Future<Map<String,bool>> addTask(TaskModel data)async{
    final http.Response res = await api.addTaskApi(data);
    if(res.statusCode == 200)return { 'Add Task Successfully': true };
    return { '${res.statusCode}': false };
  }

  @override
  Future<Map<String,bool>> deleteTask(String id) async{
    final http.Response res = await api.deleteTaskApi(id);
    if(res.statusCode == 200)return { 'Delete Task Successfully': true };
    return { '${res.statusCode}': false };
  }

  @override
  Future<Map<List<TaskModel?>?, String>> getAllTask() async{
    final http.Response res = await api.getAllTaskApi();
    if(res.statusCode == 200){
      final List decodeData = json.decode(res.body)['data']; 
      if(decodeData.isEmpty)return {[] : 'ok'};
      try{
        final List<TaskModel?> data =  (decodeData).map((e) => TaskModel.fromJson(e)).toList();
        return {data : 'ok'};
      }
      catch(e){
        print('lsfjlksdflksdfljdslfjsdljf-------->$e');
      }
    }
    return {null : '${res.statusCode}'};

  }

  @override
  Future<Map<TaskModel?, String>> getTask(String id) async{
    final http.Response res = await api.getTaskApi(id);
    if(res.statusCode == 200){
      final data = TaskModel.fromJson(json.decode(res.body));
      return {data : 'ok'};
    }
    return {null : '${res.statusCode}'};
  }

  @override
  Future<Map<String,bool>> updateTask(TaskModel data) async{
    try{
      final http.Response res = await api.updateTaskApi(data);
      if(res.statusCode == 200)return {'Updated ': true};
      return { '${res.statusCode}' : false};
    }
    catch(e){
      return { '$e' : false};
    }
  }
  
  @override
  Future<Map<List<TaskModel?>?, String>> getTaskFromDate(String date)async {
    final http.Response res = await api.getTaskFromDate(date);
    if(res.statusCode == 200){
      final List decodeData = json.decode(res.body)['data']; 
      if(decodeData.isEmpty)return {[] : 'ok'};
      try{
        final List<TaskModel?> data =  (decodeData).map((e) => TaskModel.fromJson(e)).toList();
        return {data : 'ok'};
      }
      catch(e){
        print('lsfjlksdflksdfljdslfjsdljf-------->$e');
      }
    }
    return {null : '${res.statusCode}'};

  }
  
  @override
  Future<Map<List<TaskModel?>?, String>> serachTask(String search)async {
    final http.Response res = await api.searchTask(search);
    if(res.statusCode == 200){
      final List decodeData = json.decode(res.body)['data']; 
      if(decodeData.isEmpty)return {[] : 'ok'};
      try{
        final List<TaskModel?> data =  (decodeData).map((e) => TaskModel.fromJson(e)).toList();
        return {data : 'ok'};
      }
      catch(e){
        print('lsfjlksdflksdfljdslfjsdljf-------->$e');
      }
    }
    return {null : '${res.statusCode}'};

  }

  @override
  Future<List<Map<String,dynamic>>> getChartTask() async{
    final http.Response res = await api.getChartTask();
    if(res.statusCode == 200) {
      List data = json.decode(res.body);
      return data.map((e) => e as Map<String,dynamic>).toList();
    }

    return [];
  }

} 