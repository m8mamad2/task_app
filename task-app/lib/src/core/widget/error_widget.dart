import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/styles.dart';
import 'package:taskapp/src/view/presentation/bloc/task_bloc/task_bloc.dart';

Widget errorWidget(BuildContext context,String err,double height,double marginFromTop,VoidCallback onTap)=> Column(
  children: [
    SizedBox(
      width: kwidth(context)*0.4,
      height: kheight(context)*0.5,
      child: Lottie.asset('assets/lottie/error3.json',height: height, fit: BoxFit.cover)),
    SizedBox(height: marginFromTop,),
    Text(err,style: const TextStyle(color: kFourthColor,fontWeight: FontWeight.bold,fontSize: 18),),
    SizedBox(height: kheight(context)*0.06,),
    SizedBox(
      width: kwidth(context)*0.9,
      child: BlocBuilder<TaskBloc,TaskState>(
        builder: (context, state) {
          if(state is LoadingTaskState)return loadingButton(context);
          if(state is SuccessTaskState || state is InitialTaskState || state is FailTaskState)return ElevatedButton( style: authButtonStyle(context,kThiredColor), onPressed: onTap,  child: Text('Retrieving Data')) ;
          return Container();
        },
      ),
    )
  ],
);

loadingButton(BuildContext context) =>ElevatedButton( onPressed: (){}, style: authButtonStyle(context,kThiredColor), child: const CircularProgressIndicator(),);