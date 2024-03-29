import 'package:taskapp/src/view/data/model/task_model.dart';
import 'package:taskapp/src/view/domain/repo/task_repo_header.dart';

class TaskUseCase{
  TaskRepoHeader repo;
  TaskUseCase(this.repo);
  
  Future<Map<String,bool>> addTask(TaskModel data)=> repo.addTask(data);
  Future<Map<String,bool>> deleteTask(String id)=> repo.deleteTask(id);
  Future<Map<TaskModel?, String>> getTask(String id)=> repo.getTask(id);
  Future<Map<List<TaskModel?>?, String>> getAllTask()=>repo.getAllTask();
  Future<Map<List<TaskModel?>?, String>> getTaskFromDate(String date)=>repo.getTaskFromDate(date);
  Future<Map<String,bool>> updateTask(TaskModel data)=>repo.updateTask(data);
  Future<Map<List<TaskModel?>?, String>> serachTask(String search)=>repo.serachTask(search);
  Future<List<Map<String,dynamic>>> getChartTask() => repo.getChartTask();
  
}