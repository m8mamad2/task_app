import 'package:taskapp/src/view/data/model/task_model.dart';

abstract class TaskRepoHeader{
  Future<Map<String,bool>> addTask(TaskModel data);
  Future<Map<String,bool>> deleteTask(String id);
  Future<Map<TaskModel?, String>> getTask(String id);
  Future<Map<List<TaskModel?>?, String>> getAllTask();
  Future<Map<String,bool>> updateTask(TaskModel data);
  Future<Map<List<TaskModel?>?, String>> getTaskFromDate(String date);
  Future<Map<List<TaskModel?>?, String>> serachTask(String search);
  Future<List<Map<String,dynamic>>> getChartTask();
}