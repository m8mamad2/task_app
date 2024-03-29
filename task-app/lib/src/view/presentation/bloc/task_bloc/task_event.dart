part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

final class AddTaskEvent extends TaskEvent{
  final TaskModel data;
  final BuildContext context;
  AddTaskEvent(this.data,this.context);
}

final class DeleteTaskEvent extends TaskEvent{
  final String id;
  final BuildContext context;
  DeleteTaskEvent(this.id,this.context);
}

final class GetAllTaskEvent extends TaskEvent{}

final class GetTaskFromDateEvent extends TaskEvent{
  final String date;
  final String toDay;
  GetTaskFromDateEvent(this.date,this.toDay);
}

final class GetTaskToDayEvent extends TaskEvent{
  final String toDayDate;
  GetTaskToDayEvent(this.toDayDate);
}

final class GetTaskEvent extends TaskEvent{
  final String id;
  GetTaskEvent(this.id);
}


final class UpdateTaskEvent extends TaskEvent{
 final TaskModel data;
  final BuildContext context;
  UpdateTaskEvent(this.data,this.context); 
}
