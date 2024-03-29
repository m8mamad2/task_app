// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:taskapp/src/view/data/model/notif_model.dart';
import 'package:taskapp/src/view/domain/usecase/notif_usecase.dart';

part 'notif_event.dart';
part 'notif_state.dart';

class NotifBloc extends Bloc<NotifEvent, NotifState> {
  final NotifUseCase useCase;
  NotifBloc(this.useCase) : super(InitialNotifState()) {
    
    on<GetAllNotifEvent>((event, emit)async {
        emit(LoadingNotifState());
        try{
          final List<NotifModel> data= useCase.getAllNotif();
          emit(SuccessNotifState(data));
        }
        catch(e){ emit(FailNotifState( e.toString() ));}
    });
    
    on<AddNotifEvent>((event, emit)async {
      emit(LoadingNotifState());
      try{
        await useCase.addNotif(event.notifModel);
        final List<NotifModel> data= useCase.getAllNotif();
        Navigator.of(event.context).pop();
        emit(SuccessNotifState(data));
      }
      catch(e){ emit(FailNotifState( e.toString() ));}
    });

    on<DeleteNotifEvent>((event, emit)async {
      emit(LoadingNotifState());
      try{
        await useCase.deleteNotif(event.index,event.id);
        final List<NotifModel> data= useCase.getAllNotif();
        Navigator.of(event.context).pop();
        emit(SuccessNotifState(data));
      }
      catch(e){ emit(FailNotifState( e.toString() ));}
    });

  }
}
