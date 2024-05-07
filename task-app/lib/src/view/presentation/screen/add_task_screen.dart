

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/borders.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/keys.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/styles.dart';
import 'package:taskapp/src/view/data/model/task_model.dart';
import 'package:taskapp/src/view/presentation/bloc/task_bloc/task_bloc.dart';

final List<String> priorites = ['Low','Medium','High'];
TextEditingController titleController =  TextEditingController();
TextEditingController desController =    TextEditingController();

ButtonStyle buttonStyle(BuildContext context)=> ElevatedButton.styleFrom(
  minimumSize: Size(kwidth(context), kheight(context)*0.055),
  backgroundColor: kThiredColor,
  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5) )
);

Future addTaskBottomShet(BuildContext context) async { 

  loadingButton(BuildContext context) =>ElevatedButton( onPressed: (){}, style: authButtonStyle(context,kThiredColor), child: const CircularProgressIndicator(),);
  final key = Keys.addTaskKey;

  int selected = 0;
  
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
            height: kheight(context)*0.55,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [                
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: kheight(context)*0.02, bottom: kheight(context)*0.01),
                          child: Text(
                            'Title',
                            style: const TextStyle(color: kFourthColor,fontWeight: FontWeight.w700 ),),
                        ),
                        SizedBox(
                          height: kheight(context)*0.06,
                          child: TextFormField(
                            controller: titleController,
                            style: TextStyle( color: Colors.white,fontSize: kwidth(context)*0.035 ),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Do Eat',
                              hintStyle: TextStyle( color: Colors.grey,fontSize: kwidth(context)*0.03 ),
                              enabledBorder: authBorder(kFourthColor),
                              focusedBorder: authBorder(kFourthColor),
                              focusedErrorBorder: authBorder(Colors.red),
                              errorBorder: authBorder(Colors.red),
                            ),
                          ),
                        )
                      ],
                    ),
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
                            focusedErrorBorder: authBorder(Colors.red),
                            errorBorder: authBorder(Colors.red),
                          ),
                        )
                      ],
                    ),
                
                    Padding(
                      padding: EdgeInsets.only(top: kheight(context)*0.02, bottom: kheight(context)*0.01),
                      child: Text(
                        'priority',
                        style: const TextStyle(color: kFourthColor,fontWeight: FontWeight.w700 ),),
                    ),
                    Container(
                        height: kheight(context)*0.08,
                        decoration: BoxDecoration(
                          border: Border.all(color: kFourthColor,width: 0.5),
                          borderRadius: BorderRadius.circular(6)
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 2),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () => setState(()=> selected = index),
                            child: Container(
                              width: kwidth(context)*0.3,
                              decoration: BoxDecoration(
                                color: selected == index ? kThiredColor : Colors.transparent,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(child: Text(priorites[index],style:  TextStyle(
                                fontSize: kwidth(context)*0.03,
                                fontWeight: FontWeight.w600,color: Colors.white),)),
                            ),
                          ),),
                      ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: kheight(context)*0.02),
                      child: BlocBuilder<TaskBloc,TaskState>(
                        builder: (context, state) {
                          TaskModel taskModel = TaskModel(
                              des: desController.text.trim(),
                              title: titleController.text.trim(),
                              priority: selected,
                              date: DateTime.now().toString().split(' ')[0].trim(),
                              compelete: false,
                              startTime: null,
                              endTime: null,
                              isRunning: false,
                              diffTime: '',
                            );
                          onTap(){
                            context.read<TaskBloc>().add(AddTaskEvent(taskModel,context));
                            desController.clear();
                            titleController.clear();
                            // context.navigateBack(context);
                          }
                
                          if(state is LoadingTaskState)return loadingButton(context);
                          if(state is InitialTaskState)return ElevatedButton( onPressed: onTap, style:authButtonStyle(context,kThiredColor), child: Text('Create ',style: TextStyle(color: Colors.black,fontSize: kwidth(context)*0.04),),);
                          if(state is SuccessTaskState)return ElevatedButton( onPressed: onTap, style:authButtonStyle(context,kThiredColor), child: Text('Create ',style: TextStyle(color: Colors.black,fontSize: kwidth(context)*0.04),),);
                          if(state is FailTaskState)return ElevatedButton( onPressed: onTap, style:authButtonStyle(context,Colors.red), child: Text('Create ',style: TextStyle(color: Colors.black,fontSize: kwidth(context)*0.04),),);
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

Future addTaskDialog(BuildContext context) async { 

  loadingButton(BuildContext context) =>ElevatedButton( onPressed: (){}, style: authButtonStyle(context,kThiredColor), child: const CircularProgressIndicator(),);
  final key = Keys.addTaskKey;

  int selected = 0;
  
 return await showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        backgroundColor: kSecondColor,
        shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.all( Radius.circular(20)) ),
        content: StatefulBuilder(
          builder: (context, setState) => Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: kwidth(context)*0.5 ,
              height: kheight(context)*0.55,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [                
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: kheight(context)*0.02, bottom: kheight(context)*0.01),
                            child: Text(
                              'Title',
                              style: const TextStyle(color: kFourthColor,fontWeight: FontWeight.w700 ),),
                          ),
                          SizedBox(
                            height: kheight(context)*0.05,
                            child: TextFormField(
                              controller: titleController,
                              style: const TextStyle( color: Colors.white,fontSize: 15 ),
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Do Eat',
                                hintStyle: const TextStyle( color: Colors.grey,fontSize: 15 ),
                                enabledBorder: authBorder(kFourthColor),
                                focusedBorder: authBorder(kFourthColor),
                                focusedErrorBorder: authBorder(Colors.red),
                                errorBorder: authBorder(Colors.red),
                              ),
                            ),
                          )
                        ],
                      ),
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
                            style: const TextStyle( color: Colors.white,fontSize: 15 ),
                            textInputAction: TextInputAction.next,
                            maxLines: 7,
                            minLines: 3,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'in 9 Clock To Eat Milk',
                              hintStyle: const TextStyle( color: Colors.grey,fontSize: 15 ),
                              enabledBorder: authBorder(kFourthColor),
                              focusedBorder: authBorder(kFourthColor),
                              focusedErrorBorder: authBorder(Colors.red),
                              errorBorder: authBorder(Colors.red),
                            ),
                          )
                        ],
                      ),
                  
                      Padding(
                        padding: EdgeInsets.only(top: kheight(context)*0.02, bottom: kheight(context)*0.01),
                        child: Text(
                          'priority',
                          style: const TextStyle(color: kFourthColor,fontWeight: FontWeight.w700 ),),
                      ),
                      Container(
                          width: kwidth(context),
                          height: kheight(context)*0.08,
                          decoration: BoxDecoration(
                            border: Border.all(color: kFourthColor,width: 0.5),
                            borderRadius: BorderRadius.circular(6)
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 2),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () => setState(()=> selected = index),
                              child: Container(
                                width: kwidth(context)*0.139,
                                decoration: BoxDecoration(
                                  color: selected == index ? kThiredColor : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(child: Text(priorites[index],
                                  style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),)),
                              ),
                            ),),
                        ),
                      
                      const Spacer(),
                      
                      Padding(
                        padding: EdgeInsets.only(bottom: kheight(context)*0.02),
                        child: BlocBuilder<TaskBloc,TaskState>(
                          builder: (context, state) {
                            TaskModel taskModel = TaskModel(
                                des: desController.text.trim(),
                                title: titleController.text.trim(),
                                priority: selected,
                                date: DateTime.now().toString().split(' ')[0].trim(),
                                compelete: false,
                                startTime: null,
                                endTime: null,
                                isRunning: false,
                                diffTime: '',
                              );
                            onTap(){
                              context.read<TaskBloc>().add(AddTaskEvent(taskModel,context));
                              desController.clear();
                              titleController.clear();
                              // context.navigateBack(context);
                            }
                  
                            if(state is LoadingTaskState)return loadingButton(context);
                            if(state is InitialTaskState)return ElevatedButton( onPressed: onTap, style:authButtonStyleDesktop(context,kThiredColor), child:const Text('Create ',style: TextStyle(color: Colors.black,fontSize: 15),),);
                            if(state is SuccessTaskState)return ElevatedButton( onPressed: onTap, style:authButtonStyleDesktop(context,kThiredColor), child:const Text('Create ',style: TextStyle(color: Colors.black,fontSize: 15),),);
                            if(state is FailTaskState)return ElevatedButton( onPressed: onTap,    style:authButtonStyleDesktop(context,Colors.red), child:const Text('Create ',style: TextStyle(color: Colors.black,fontSize: 15),),);
                            return Container();
                          },
                        ),
                      )
                    ],
                  ),
                )),
            ),
          ),
        ),
      );
    },);
}


