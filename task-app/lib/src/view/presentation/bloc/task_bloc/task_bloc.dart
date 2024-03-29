// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:taskapp/src/core/extenstion/navigation_extension.dart';
import 'package:taskapp/src/view/data/model/task_model.dart';
import 'package:taskapp/src/view/domain/usecase/task_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskUseCase useCase;
  TaskBloc(this.useCase) : super(InitialTaskState()) {
    

    on<AddTaskEvent>((event, emit)async {
      emit(LoadingTaskState());
      try{
        String toDayDate = DateTime.now().toString().split(' ')[0];
        await useCase.addTask(event.data)
          .then((value) async{
            if(value.values.first){
              emit(SuccessTaskState(
                taskFromDateModels: (await useCase.getTaskFromDate(toDayDate)).keys.first,
                taskToDayModel:( await useCase.getTaskFromDate(toDayDate)).keys.first,
                charData: (await useCase.getChartTask())
              ));
              Navigator.of(event.context).pop();
            }
            else { emit(FailTaskState(value.keys.first)); }
          });
      }
      catch(e){ emit(FailTaskState(e.toString())); }
     });
     
    on<DeleteTaskEvent>((event, emit)async {
      emit(LoadingTaskState());
      try{
        String toDayDate = DateTime.now().toString().split(' ')[0];
        await useCase.deleteTask(event.id)
          .then((value) async{
            if(value.values.first){
              emit(SuccessTaskState(
                taskFromDateModels: (await useCase.getTaskFromDate(toDayDate)).keys.first,
                taskToDayModel:( await useCase.getTaskFromDate(toDayDate)).keys.first,
                charData: (await useCase.getChartTask())
              ));
              // Navigator.of(event.context).pop();

            }
            else { emit(FailTaskState(value.keys.first)); }
            }
          );
      }
      catch(e){ emit(FailTaskState(e.toString())); }
     });
     
    on<GetTaskEvent>((event, emit)async {
      emit(LoadingTaskState());
      // try{
      //   await useCase.getTask(event.id)
      //     .then((value) => value.keys.first != null 
      //       ? emit(SuccessTaskState(taskModel: value.keys.first))
      //       : emit(FailTaskState('Fail To Add Task')));
      // }
      // catch(e){ emit(FailTaskState(e.toString())); }
     });

    on<GetAllTaskEvent>((event, emit)async {
      emit(LoadingTaskState());
      try{
        await useCase.getAllTask()
          .then((value) => value.values.first == 'ok'
            ? emit(SuccessTaskState())
            : emit(FailTaskState('Fail To Get Tasks 1')));
      }
      catch(e){ emit(FailTaskState(e.toString())); }
     });
    
    on<GetTaskFromDateEvent>((event, emit)async {
      emit(LoadingTaskState());
      try{

        await useCase.getTaskFromDate(event.date)
          .then((value) async=> value.values.first == 'ok'
            ? emit(SuccessTaskState(
                taskFromDateModels: value.keys.first,
                taskToDayModel:( await useCase.getTaskFromDate(event.toDay)).keys.first,
                charData: (await useCase.getChartTask())))
            : emit(FailTaskState('Fail To Get Tasks2'))
          );
      }
      catch(e){ emit(FailTaskState(e.toString())); }
     });
    
    on<GetTaskToDayEvent>((event, emit)async {
      emit(LoadingTaskState());
      try{
        await useCase.getTaskFromDate(event.toDayDate)
          .then((value) async=> value.values.first=='ok'
            ? emit(SuccessTaskState(taskToDayModel: value.keys.first))
            : emit(FailTaskState(value.values.first))
          );
      }
      catch(e){ emit(FailTaskState(e.toString())); }
     });
      
    on<UpdateTaskEvent>((event, emit)async {
      emit(LoadingTaskState());
      try{
        String toDayDate = DateTime.now().toString().split(' ')[0];
        await useCase.updateTask(event.data)
          .then((value) async{
            if(value.values.first){
              emit(SuccessTaskState(
                taskFromDateModels: (await useCase.getTaskFromDate(toDayDate)).keys.first,
                taskToDayModel:( await useCase.getTaskFromDate(toDayDate)).keys.first,
                charData: (await useCase.getChartTask())
              ));
            }
            else { emit(FailTaskState(value.keys.first)); }
          });
      }
      catch(e){ emit(FailTaskState(e.toString())); }
     });
    
  }
}


