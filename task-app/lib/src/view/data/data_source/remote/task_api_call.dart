// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:taskapp/src/view/data/model/task_model.dart';
import '../../../../core/utils/api.dart';

class TaskApiCall{

  Api api = Api.instace;
  Future<http.Response> addTaskApi (TaskModel data) async =>  await api.post('task/addTask',  data.toJson());
  Future<http.Response> updateTaskApi(TaskModel data) async => await api.put('task/updateTask', data.forUpdateFields());
  Future<http.Response> deleteTaskApi(String id) async => await api.delete('task/deleteTask', { "id" : id });
  Future<http.Response> getTaskApi(String id) async => await api.post('task/getTask', { "id": id });
  Future<http.Response> getAllTaskApi() async => await api.get('task/getAllTask',);
  Future<http.Response> getTaskFromDate(String date) async => await api.post('task/getTaskFromDate',{ "date" : date });
  Future<http.Response> searchTask(String search) async => await api.post('task/searchTask',{ "search" : search });
  Future<http.Response> getChartTask() async => await api.get('task/getChart');

}

