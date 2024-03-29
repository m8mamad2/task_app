part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class InitialTaskState extends TaskState {}
final class LoadingTaskState extends TaskState {}
final class SuccessTaskState extends TaskState {
  final List<TaskModel?>? taskToDayModel;
  final List<TaskModel?>? taskFromDateModels;
  final List<Map<String,dynamic>>? charData;
  SuccessTaskState({this.taskToDayModel, this.taskFromDateModels,this.charData});
}
final class FailTaskState extends TaskState {
  final String data;
  FailTaskState(this.data);
}
