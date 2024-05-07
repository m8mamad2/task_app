// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:taskapp/src/core/responsive_chose/responsive_choses.dart';
import 'package:taskapp/src/view/data/model/user_model_localy.dart';
import 'package:taskapp/src/view/domain/usecase/usre_usecase.dart';
import 'package:taskapp/src/view/presentation/screen/auth/auth_screen_mobile.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  UserUsecase usecase;
  UserBloc(this.usecase) : super(InitialUserState()) {
    
    on<GetUserEvent>((event, emit)async {

      try{
          final UserModelLocaly? data = await usecase.getUser();
          emit(SucessUserState(data));
      }
      catch(e){ emit(FailUserState(e.toString()));}

     });
    
    on<AddUserToDBEvent>((event, emit)async {
      emit(LoadingUserState());

      try{
        await usecase.addUserToDB()
          .then((value)async{
            if(value.values.first){
              final data = await usecase.getUser();
              emit(SucessUserState(data));
            }
            else { emit(FailUserState(value.keys.first)); }
          });
      }
      catch(e){ emit(FailUserState(e.toString())); }

    });

    on<UpdateUserNameEvent>((event, emit)async {
      emit(LoadingUserState());

      try{
        await usecase.updateUserName(event.name)
          .then((value)async{
            if(value){
              final data = await usecase.getUser();
              Navigator.of(event.context).pop();
              emit(SucessUserState(data));
            }
            else { emit(FailUserState('Error ')); }
          });
      }
      catch(e){ emit(FailUserState(e.toString())); }
    });
    
    on<UpdateUserAvatarEvent>((event, emit)async {
      emit(LoadingUserState());

      try{
        await usecase.updateProfileAvatar(event.profileId)
          .then((value)async{
            if(value){
              final data = await usecase.getUser();
              Navigator.of(event.context).pop();
              emit(SucessUserState(data));
            }
            else { emit(FailUserState('Error ')); }
          });
      }
      catch(e){ emit(FailUserState(e.toString())); }
    });

    on<DeleteUserAccountEvent>((event, emit) async {
      emit(LoadingUserState());

      try{
        await usecase.deleteAccount()
          .then((value)async=> value
            ? Navigator.of(event.context).pushReplacement(MaterialPageRoute(builder: (context) => loginResponsiveChoese())):
              emit(FailUserState('Fail To Delete Acoount')));
      }
      catch(e){ emit(FailUserState(e.toString())); }
     });

    on<LogoutUserEvent>((event, emit)async {
      emit(LoadingUserState());
      try{
        await usecase.logOutUser();
        Navigator.of(event.context).pushReplacement(MaterialPageRoute(builder: (context) => loginResponsiveChoese()));
      }
      catch(e){ emit(FailUserState(e.toString())); }

     });

  }
}


