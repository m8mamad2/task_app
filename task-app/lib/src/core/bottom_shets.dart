// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:taskapp/src/core/borders.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/extenstion/navigation_extension.dart';
import 'package:taskapp/src/core/keys.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/styles.dart';
import 'package:taskapp/src/core/utils/random_number.dart';
import 'package:taskapp/src/core/widget/details_bottom_shet_widgets.dart';
import 'package:taskapp/src/core/widget/textfiedls.dart';
import 'package:taskapp/src/view/data/model/notif_model.dart';
import 'package:taskapp/src/view/data/model/task_model.dart';
import 'package:taskapp/src/view/presentation/bloc/notif_bloc/notif_bloc.dart';
import 'package:taskapp/src/view/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:taskapp/src/view/presentation/bloc/user_bloc/user_bloc.dart';


Future addNotifBottomshet(BuildContext context) async {
  
  loadingButton(BuildContext context) =>ElevatedButton( onPressed: (){}, style: authButtonStyle(context,kThiredColor), child: const CircularProgressIndicator(),);

  
  final key = Keys.addNotifBottomShetKey;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  Duration durationTimeFronNotif= Duration();

  return await showModalBottomSheet(
    backgroundColor: kSecondColor,
    shape:const RoundedRectangleBorder(
      borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20)) ),
    context: context, 
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: kwidth(context),
            height: kheight(context)*0.52,
            decoration: const  BoxDecoration(
              border: Border(top: BorderSide(color: kThiredColor)),
              color: kMainColor,
              borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            child: Form(
              key: key,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.04),
                child: Column(
                  children: [
                    bottomSheTextFiedlWidget(context,'Title','start homeWork',titleController,false),
                    bottomSheTextFiedlWidget(context,'Description','i should start from saving it',desController,false),
                    bottomSheTextFiedlWidget(context,'Start Time','',timeController,true,()async{
                      final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) => Theme(
                              data: ThemeData.dark().copyWith( colorScheme: const ColorScheme.dark(primary: Colors.white,onSurface: kThiredColor) ), 
                              child: child!),
                          );
                          
                          setState((){
                          if (picked != null) {
                            DateTime x = DateTime.now();
                            DateTime pickedTime = DateTime(x.year,x.month,x.day,picked.hour,picked.minute);
                            DateTime now = DateTime.now();
                            Duration difference = pickedTime.difference(now);
                            int hour = difference.inHours % 24;
                            int minute = difference.inMinutes % 60;
                          
                            timeController.text = '${picked.hour}:${picked.minute}';
                            durationTimeFronNotif = Duration(hours: hour,minutes: minute);
                          }
                          });
                    }),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: kheight(context)*0.03),
                      child: BlocBuilder<NotifBloc,NotifState>(
                        builder: (context, state) {

                          NotifModel notifModel = NotifModel(
                            randomNumber(), 
                            titleController.text.trim(), 
                            desController.text.trim(), 
                            durationTimeFronNotif.inHours, 
                            durationTimeFronNotif.inMinutes, 
                            0, 
                            'What is This?');

                          onTap()=> key.currentState!.validate() 
                            ? context.read<NotifBloc>().add(AddNotifEvent(notifModel,context))
                            : null;
                          
                          if(state is LoadingNotifState)return loadingButton(context);
                          if(state is SuccessNotifState)return ElevatedButton(onPressed: onTap,style: authButtonStyle(context,kThiredColor),child: Text('ok',style: TextStyle(color: Colors.black,fontSize: kwidth(context)*0.04),),);
                          if(state is InitialNotifState)return ElevatedButton(onPressed: onTap,style: authButtonStyle(context,kThiredColor),child: Text('ok',style: TextStyle(color: Colors.black,fontSize: kwidth(context)*0.04),),);
                          if(state is FailNotifState)return ElevatedButton( onPressed: onTap, style: authButtonStyle(context,kRedColor), child: const Text('Fail ! Try Again',style: TextStyle(color: kFourthColor),),);
                          return Container();
                        },
                      ),
                    )
                  ],
                ),
              )),
          ),
        ),
      );
    },);

}

Future deleteNotifBottomshet(BuildContext context,int index, int id) async {
  
  loadingButton(BuildContext context) =>ElevatedButton( onPressed: (){}, style: deleteButtonStyle(context,), child: const CircularProgressIndicator(),);


  return await showModalBottomSheet(
    backgroundColor: kSecondColor,
    shape:const RoundedRectangleBorder(
      borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20)) ),
    context: context, 
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          width: kwidth(context),
          height: kheight(context)*0.24,
          decoration: const  BoxDecoration(
            border: Border(top: BorderSide(color: kThiredColor)),
            color: kMainColor,
            borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),
          child: Form(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.04),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: kheight(context)*0.03),
                    child: Text('Are you Shure You want Delete This Notification? ',
                    style: TextStyle(color: Colors.white,fontSize: kwidth(context)*0.04,fontWeight: FontWeight.w600),)),
                  const Spacer(),

                  Padding(
                    padding: EdgeInsets.only(bottom: kheight(context)*0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: ()=> context.navigateBack(context), 
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: Size(kwidth(context)*0.43, kheight(context)*0.055),
                            backgroundColor: kThiredColor,
                            shape: RoundedRectangleBorder(
                              // side: const BorderSide(color: kFourthColor),
                              borderRadius: BorderRadius.circular(6),
                            )
                          ),
                          child: Text('Cancel',style: TextStyle(color: kFourthColor),)),
                        BlocBuilder<NotifBloc,NotifState>(
                          builder: (context, state) {
                            
                            onTap()=> context.read<NotifBloc>().add(DeleteNotifEvent(index, id,context));

                            if(state is LoadingNotifState) return loadingButton(context);
                            if(state is InitialNotifState) return ElevatedButton( onPressed: onTap, style: deleteButtonStyle(context), child: Text('Ok',style: deleteButtonStyleTextStyle(context),),);
                            if(state is SuccessNotifState)  return ElevatedButton( onPressed: onTap, style: deleteButtonStyle(context), child: Text('Ok',style: deleteButtonStyleTextStyle(context),),);
                            if(state is FailNotifState)    return ElevatedButton( onPressed: onTap, style: deleteButtonStyle(context,), child: const Text('Fail ! Try Again',style: TextStyle(color: Colors.white),),);
                            return Container();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
        ),
      );
    },);

}

Future changeInfoBottomShet(BuildContext context,String lable) async {
  
  final key = Keys.changeInfoBottomShetKey;
  final TextEditingController controller = TextEditingController();

  loadingButton(BuildContext context) =>ElevatedButton( onPressed: (){}, style: authButtonStyle(context,kThiredColor), child: const CircularProgressIndicator(),);
  failButton(BuildContext context) =>ElevatedButton( onPressed: ()=>context.read<UserBloc>().add(UpdateUserNameEvent(controller.text.trim(),context)), style: authButtonStyle(context,kRedColor), child: const Text('Fail ! Try Again',style: TextStyle(color: kFourthColor),),);


  return await showModalBottomSheet(
    backgroundColor: kSecondColor,
    shape:const RoundedRectangleBorder(
      borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20)) ),
    context: context, 
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          width: kwidth(context),
          height: kheight(context)*0.27,
          decoration: const  BoxDecoration(
            border: Border(top: BorderSide(color: kThiredColor)),
            color: kMainColor,
            borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),
          child: Form(
            key: key,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.04),
              child: Column(
                children: [
                  bottomSheTextFiedlWidget(context,lable,'' ,controller,false,null,true),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: kheight(context)*0.03),
                    child: BlocBuilder<UserBloc,UserState>(
                      builder: (context, state) {
                        onTap()=>
                          context.read<UserBloc>().add(UpdateUserNameEvent(controller.text.trim(),context));
                        
                        print(state);
                        
                        if(state is LoadingUserState) return loadingButton(context);
                        if(state is InitialUserState) return ElevatedButton( onPressed: onTap, style: authButtonStyle(context,kThiredColor), child: Text('Ok',style: changeInfoBottomShetTextStyle(context),),);
                        if(state is SucessUserState)  return ElevatedButton( onPressed: onTap, style: authButtonStyle(context,kThiredColor), child: Text('Ok',style: changeInfoBottomShetTextStyle(context),),);
                        if(state is FailUserState)    return failButton(context);
                        return Container();
                      },
                    ),
                  )
                ],
              ),
            )),
        ),
      );
    },);
}

Future deleteBottomShet(BuildContext context,bool isDeleteAcoount,VoidCallback onTap,String title) async {
  

  loadingButton(BuildContext context) =>ElevatedButton( onPressed: (){}, style: deleteButtonStyle(context,), child: const CircularProgressIndicator(),);
  failButton(BuildContext context)    => ElevatedButton( onPressed: (){}, style: deleteButtonStyle(context,), child: const Text('Fail ! Try Again',style: TextStyle(color: Colors.white),),);


  return await showModalBottomSheet(
    backgroundColor: kSecondColor,
    shape:const RoundedRectangleBorder(
      borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20)) ),
    context: context, 
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          width: kwidth(context),
          height: isDeleteAcoount ? kheight(context)*0.38 : kheight(context)*0.24,
          decoration: const  BoxDecoration(
            border: Border(top: BorderSide(color: kThiredColor)),
            color: kMainColor,
            borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),
          
          child: Form(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.04),
              child: Column(
                children: [
                  isDeleteAcoount
                    ? Container(
                        margin: const EdgeInsets.only(top: 9),
                        child: Icon(Icons.delete_forever_outlined,color: kRedColor,size: kwidth(context)*0.3,))
                    : const SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: kheight(context)*0.03),
                    child: Text(title,
                    style: TextStyle(color: Colors.white,fontSize: kwidth(context)*0.04,fontWeight: FontWeight.w600),)),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: kheight(context)*0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: ()=> context.navigateBack(context), 
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: Size(kwidth(context)*0.43, kheight(context)*0.055),
                            backgroundColor: kThiredColor,
                            shape: RoundedRectangleBorder(
                              // side: const BorderSide(color: kFourthColor),
                              borderRadius: BorderRadius.circular(6),
                            )
                          ),
                          child: Text('Cancel',style: TextStyle(color: kFourthColor),)),
                        BlocBuilder<UserBloc,UserState>(
                          builder: (context, state) {
                            if(state is LoadingUserState) return loadingButton(context);
                            if(state is InitialUserState) return ElevatedButton( onPressed: onTap, style: deleteButtonStyle(context), child: Text('Ok',style: deleteButtonStyleTextStyle(context),),);
                            if(state is SucessUserState)  return ElevatedButton( onPressed: onTap, style: deleteButtonStyle(context), child: Text('Ok',style: deleteButtonStyleTextStyle(context),),);
                            if(state is FailUserState)    return failButton(context);
                            return Container();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
        ),
      );
    },);

}

Future detailsNotifBottomShet(BuildContext context,TaskModel taskModel,StopWatchTimer stopWatchTimer,BuildContext context0) async {

  String priorityInit(int data){
    switch(data){
      case 0 : return '0';
      case 1 : return '1';
      case 2 : return '2';
      default: return "";
    }
  }

  TextEditingController titleController = TextEditingController(text: taskModel.title);
  TextEditingController desController = TextEditingController(text: taskModel.des);
  TextEditingController priorityController = TextEditingController(text: priorityInit(taskModel.priority ?? 0));
  TextEditingController dateController = TextEditingController(text: taskModel.date);
  TextEditingController startController = TextEditingController(text:  taskModel.startTime ?? '');
  TextEditingController endController = TextEditingController(text:    taskModel.endTime ?? '');
  TextEditingController diffController = TextEditingController(text: taskModel.diffTime ?? "");


  TaskModel data = TaskModel(
    id: taskModel.id,
    date: dateController.text,
    startTime: startController.text,
    endTime: endController.text,
    diffTime: diffController.text,
    compelete: taskModel.compelete,
    isRunning: taskModel.isRunning,
    user: taskModel.user,
    createdAt: taskModel.createdAt,
    iV: taskModel.iV,
    updatedAt: taskModel.updatedAt
  );

  completeOnTap(BuildContext context)async{
    if(startController.text.isEmpty){ return await showModalBottomSheet(context: context, builder: (context) => Container(
      height: kheight(context)*0.3,     
      width: kwidth(context),
      color: kRedColor,
      child: const Center(child: Text('Please First Run it And Then Stop it'),),
    ),); }
    else{
      data.compelete = true;
      context.read<TaskBloc>().add(UpdateTaskEvent(data,context));
      // Future.delayed(const Duration(seconds: 2),()=>context.navigateBack(context));
    }
  }
  
  runOnTap(BuildContext context)async{
    data.isRunning = true;
    data.startTime=  startController.text.isEmpty ? DateTime.now().toString() : startController.text.trim();    

    context.read<TaskBloc>().add(UpdateTaskEvent(data,context));
    // context.navigateBack(context);
  }

  stopOnTap(BuildContext context)async{
    data.isRunning = false;
    data.endTime= DateTime.now().toString();
    stopWatchTimer.rawTime.listen((event) async{

      final displayTime = StopWatchTimer.getDisplayTime(event);
      data.diffTime = displayTime.toString();

      
    });
    
    stopWatchTimer.onStopTimer();
    context.read<TaskBloc>().add(UpdateTaskEvent(data,context));
    // context.navigateBack(context);
  }
    
  
  return await showModalBottomSheet(
    context: context, 
    backgroundColor: kSecondColor,
    shape:const RoundedRectangleBorder(
      borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20)) ),
    isScrollControlled: true,
    builder: (context) => Container(
        width: kwidth(context),
        padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.04),
        height: kheight(context)*0.82,
        decoration: const  BoxDecoration(
          border: Border(top: BorderSide(color: kThiredColor)),
          color: kMainColor,
          borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! Title
            oneColumnDetailsBottomShetWidget(context,'Title',titleController,false,false, false),
            
            Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: kheight(context)*0.02, bottom: kheight(context)*0.01),
                      child: const Text(
                        'Description',
                        style: TextStyle(color: kFourthColor,fontWeight: FontWeight.w700 ),),
                    ),
                    TextFormField(
                      controller: desController,
                      style: TextStyle( color: Colors.white,fontSize: kwidth(context)*0.035 ),
                      textInputAction: TextInputAction.next,
                      maxLines: 7,
                      minLines: 3,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'in 9 Clock To Eat Milk',
                        hintStyle: TextStyle( color: Colors.grey,fontSize: kwidth(context)*0.03 ),
                        enabledBorder: authBorder(kFourthColor),
                        focusedBorder: authBorder(kFourthColor),
                        focusedErrorBorder: authBorder(kRedColor),
                        errorBorder: authBorder(kRedColor),
                      ),
                    )
                  ],
                ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                oneColumnDetailsBottomShetWidget(context,'Priority',priorityController,true,false, false),
                oneColumnDetailsBottomShetWidget(context,'Date',dateController,true,false, false),
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                oneColumnForHourBottomShetWidget(context,'Start Hour',startController.text,true,false,true ),
                oneColumnForHourBottomShetWidget(context,'Stop Hour', endController.text,true,false,  true ),
            ],),

            oneColumnDetailsBottomShetWidget(context,'Hour Spaende on it',diffController,false,false, false),
            
            const Spacer(),
            
            Builder(
              builder: (context) {
                return Container(
                  height: kheight(context)*0.055,
                  margin: EdgeInsets.only(bottom: kheight(context)*0.02),
                  child: BlocConsumer<TaskBloc,TaskState>(
                    listener: (context, state) async{
                        if(state is SuccessTaskState)return context.navigateBack(context);
                    },
                    builder: (context, state) {
                      if(state is LoadingTaskState) return ElevatedButton(onPressed: (){}, style: authButtonStyle(context,),child: const CircularProgressIndicator(color: kThiredColor,));
                      if(state is SuccessTaskState || state is InitialTaskState){
                         return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          
                              ////*
                              taskModel.compelete! || taskModel.isRunning! 
                                ? const SizedBox.shrink() 
                                : BlocBuilder<TaskBloc,TaskState>(
                                  builder: (context, state) {
                                    if(state is SuccessTaskState || state is InitialTaskState) {
                                      return ElevatedButton(
                                        onPressed:()=> completeOnTap(context), 
                                        style: detailsButtonStyle(context,true,kThiredColor),
                                        child:Text('complete it',style: deleteButtonStyleTextStyle(context),));
                                    }
                                    if(state is FailTaskState) return ElevatedButton(onPressed: ()=> completeOnTap(context), child: const Text('Fail please Try Again'));
                                    return Container();
                                  }, ),
                              
                              ////*
                              taskModel.compelete! 
                                ? SizedBox(width: kwidth(context)*0.9,child: ElevatedButton(onPressed: ()=>context.navigateBack(context),style: authButtonStyle(context,kThiredColor), child: Text('ok Back',style: deleteButtonStyleTextStyle(context),),))
                                : BlocBuilder<TaskBloc,TaskState>(
                                    builder: (context, state) {
                                      if(state is LoadingTaskState)return ElevatedButton(onPressed: (){}, style: detailsButtonStyle(context, false),child: const CircularProgressIndicator(color: Colors.amber,)) ;
                                      if(state is SuccessTaskState || state is InitialTaskState) {
                                        return taskModel.isRunning!
                                          ? SizedBox(
                                              width:kwidth(context)*0.9,
                                              child: ElevatedButton(onPressed: ()=>stopOnTap(context), style:authButtonStyle(context,kRedColor),child: Text('stop it',style: deleteButtonStyleTextStyle(context),)))
                                          : ElevatedButton(onPressed: ()=>runOnTap(context), style: detailsButtonStyle(context,false,Colors.blue),child:Text('Run it',style: deleteButtonStyleTextStyle(context),));
                                      }
                                      if(state is FailTaskState){
                                        return ElevatedButton(onPressed: taskModel.isRunning! ? ()=>stopOnTap(context) : ()=>runOnTap(context) , child: const Text('Fail please Try Again'));
                                      }
                                      return Container();
                                    },
                                )
                            
                            ],
                          );
                      }
                      if(state is FailTaskState) return ElevatedButton(onPressed: (){}, style: authButtonStyle(context,kRedColor),child: Text('Failed - Try Again'));
                      return Container();
                    },
                  ),
                );
              }
            ),

          ],  
        ),
      )
    );
  
}







