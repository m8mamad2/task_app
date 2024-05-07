
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:taskapp/src/core/bottom_shets.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/view/data/model/task_model.dart';
import 'package:taskapp/src/view/presentation/bloc/task_bloc/task_bloc.dart';


class CardTaskWidgetDesktop extends StatefulWidget {
  final TaskModel data;
  const CardTaskWidgetDesktop({super.key,required this.data});

  @override
  State<CardTaskWidgetDesktop> createState() => _CardTaskWidgetDesktopState();
}
class _CardTaskWidgetDesktopState extends State<CardTaskWidgetDesktop> {

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  late TaskModel data;
  
  
  @override
  void initState() {
    super.initState();
    data = widget.data;
    
    DateTime x = DateTime.now();
    final int startHour = widget.data.startTime == null || widget.data.startTime!.isEmpty 
          ? x.hour
          : int.parse(widget.data.startTime?.split(' ')[1].split('.')[0].split(':')[0] ?? '0');
    final int startMinute = widget.data.startTime == null || widget.data.startTime!.isEmpty 
          ? x.minute
          : int.parse(widget.data.startTime?.split(' ')[1].split('.')[0].split(':')[1] ?? '0');

    final int startSecond = widget.data.startTime == null || widget.data.startTime!.isEmpty 
          ? x.second
          : int.parse(widget.data.startTime?.split(' ')[1].split('.')[0].split(':')[2] ?? '0');


    DateTime pickedTime = DateTime(x.year,x.month,x.day,startHour,startMinute,startSecond);
    DateTime now = DateTime.now();
    Duration difference = now.difference(pickedTime);

    int hour = difference.inHours % 24;
    int minute = difference.inMinutes % 60;
      
    _stopWatchTimer.setPresetHoursTime (data.diffTime == null || data.diffTime!.isEmpty ? hour :   int.parse(data.diffTime?.split(':')[0] ?? '0'));
    _stopWatchTimer.setPresetMinuteTime(data.diffTime == null || data.diffTime!.isEmpty ? minute : int.parse(data.diffTime?.split(':')[1] ?? '0'));
    _stopWatchTimer.setPresetSecondTime(data.diffTime == null || data.diffTime!.isEmpty ? minute : int.parse(data.diffTime?.split('.')[0].split(':')[2] ?? '0'));

    _stopWatchTimer.onStartTimer();
  }

  @override
  void dispose()async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }


  
  //! Error ->>>>>>>>>> Priority should be like this ---> priorityInit(taskModel.priority ?? 0)

  completeOnTap(BuildContext context)async{
    if(widget.data.startTime == null || widget.data.startTime!.isEmpty){ 
      return await showDialog(context: context, builder: (context) => Container(
      height: kheight(context)*0.3,     
      width: kwidth(context),
      color: kRedColor,
      child: const Center(child: Text('Please First Run it And Then Stop it'),),
      ),); 
    }
    else{
      data.compelete = true;
      context.read<TaskBloc>().add(UpdateTaskEvent(data,context));
    }
  }
  
  runOnTap(BuildContext context)async{
    data.isRunning = true;
    data.startTime=  widget.data.startTime == null || widget.data.startTime!.isEmpty ? DateTime.now().toString() : widget.data.startTime!.trim();    
    context.read<TaskBloc>().add(UpdateTaskEvent(data,context));
  }

  stopOnTap(BuildContext context)async{
    data.isRunning = false;
    data.endTime= DateTime.now().toString();
    _stopWatchTimer.rawTime.listen((event) async{

      final displayTime = StopWatchTimer.getDisplayTime(event);
      data.diffTime = displayTime.toString();

      
    });
    
    _stopWatchTimer.onStopTimer();
    context.read<TaskBloc>().add(UpdateTaskEvent(data,context));
    // context.navigateBack(context);
  }
   


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: bgTaskCardColor(data.isRunning!, data.compelete!),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          //! Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! level
              Container(
                margin: EdgeInsets.only(bottom: kheight(context)*0.015,top: kheight(context)*0.02,),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: kwidth(context)*0.01, 
                    vertical: kheight(context)*0.0022),
                  child: Text(
                    data.priority == 1 ? 'High' : 'medium',
                    style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              
              //! title
              SizedBox(
                height: kheight(context)*0.05,
                width: kwidth(context)*0.7,
                child: Text(
                  data.title!.length > 40 ?
                    '${data.title!.substring(0,40)} ...'
                    :data.title ?? '',
                  style: const TextStyle( fontSize: 26, fontWeight: FontWeight.w600 ),
                ),
              ),
              
              SizedBox(
                height: kheight(context)*0.09,
                width: kwidth(context)*0.7,
                child: Text(
                  data.des!.length > 40 ?
                    '${data.des!.substring(0,40)} ...'
                    :data.des ?? '',
                  style: const TextStyle( fontSize: 19, fontWeight: FontWeight.w400 ),
                ),
              ),
      
              //! date
              Row(
                children: [
                  Icon(Icons.calendar_month_outlined,size: 20,),
                  const SizedBox(width: 3,),
                  Text(data.date ?? '',style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400
                  ),)
                ],),
              
              //! start & end -> Time
              Container(
                margin: EdgeInsets.only(top: kheight(context)*0.03),
                width: kwidth(context)*0.72,
                child: Row(
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        startEndTimeWidget(context,data.startTime,true),
                        SizedBox(width: kwidth(context)*0.01,),
                        
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 0.3),
                            borderRadius: BorderRadius.circular(6)
                          ),
                          child: data.compelete!
                            ? Text(data.diffTime?.split('.')[0] == null || data.diffTime!.split('.')[0].isEmpty ? '00:00:00' : data.diffTime!.split('.')[0],style: textStyle(context),)
                            : data.isRunning!
                              ? streamDiffWidget(_stopWatchTimer)
                              : Text(data.diffTime?.split('.')[0] == null || data.diffTime!.split('.')[0].isEmpty ? '00:00:00' : data.diffTime!.split('.')[0],style: textStyle(context)) ),
      
                            
                        SizedBox(width: kwidth(context)*0.01,),
                        startEndTimeWidget(context,data.endTime ,false),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          
          //! is Complte or Not
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6 ),
            child: Row(
              children: [

                 
                Expanded(
                  child: InkWell(
                    onTap: !widget.data.compelete! && widget.data.isRunning!
                      ?()=> completeOnTap(context)
                      :(){},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:  const BorderRadius.all(Radius.circular(20)),
                        color: data.compelete! ? kLightGreenColor : data.isRunning! 
                          ?  kLightBlueColor
                          :  kLightRedColor,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          child: Text(
                            !widget.data.compelete! && widget.data.isRunning! 
                              ?'Complete it'
                              :data.compelete! ? 'Done ✅' : data.isRunning! ? 'Runing 🏃' : 'Stoping  🛑',
                            style: const TextStyle(fontWeight: FontWeight.w700,),
                          ),
                        ), ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 5,),

                data.compelete! 
                  ? const SizedBox.shrink()
                  : Expanded(
                    child: InkWell(
                      onTap: widget.data.isRunning! ?()=>stopOnTap(context) : ()=> runOnTap(context) ,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:  const BorderRadius.all(Radius.circular(20)),
                          color: data.compelete! ? kLightGreenColor : data.isRunning! 
                            ?  kLightBlueColor
                            :  kLightRedColor,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            child: BlocBuilder<TaskBloc, TaskState>(
                              builder: (context, state) {
                                if(state is LoadingTaskState) return CircularProgressIndicator();
                                if(state is SuccessTaskState)return Text(data.isRunning! ? 'Stop it' : 'Run it',style:const TextStyle(fontWeight: FontWeight.w700,));
                                if(state is FailTaskState) return Text('Fail please Try Again');
                                return Container();
                              },
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          )
        
        ],
      ),
    );
  }

  
}

TextStyle textStyle(BuildContext context)=> TextStyle(fontSize: 14);
Widget streamDiffWidget(StopWatchTimer stopWatchTimer)=> StreamBuilder<int>(
  stream: stopWatchTimer.rawTime, 
  builder: (context, snapshot) {
    final value = snapshot.data;
    final displayTime = StopWatchTimer.getDisplayTime(value ?? 0);
    return Text(displayTime.isEmpty || displayTime == '0' ? '00:00:00' : displayTime.split('.')[0],style: textStyle(context));
  },);

Widget startEndTimeWidget(BuildContext context,String? title,bool isStart)=> Row(
  children: [
    Icon(isStart ? Icons.hourglass_top_outlined : Icons.hourglass_bottom,
    size: 14,),
    Text(title?.split(' ').last.split('.').first == null 
      ? isStart 
        ? 'start time' 
        : 'endTime'
      :title!.split(' ').last.split('.').first
      ,style: TextStyle( fontSize: 14 ,fontWeight: FontWeight.w300),)
  ],
);