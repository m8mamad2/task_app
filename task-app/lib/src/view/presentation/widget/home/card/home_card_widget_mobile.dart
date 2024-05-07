
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:taskapp/src/core/bottom_shets.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/view/data/model/task_model.dart';


class CardTaskWidgetMobile extends StatefulWidget {
  final TaskModel data;
  const CardTaskWidgetMobile({super.key,required this.data});

  @override
  State<CardTaskWidgetMobile> createState() => _CardTaskWidgetMobileState();
}
class _CardTaskWidgetMobileState extends State<CardTaskWidgetMobile> {

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kheight(context)*0.008),
      padding: EdgeInsets.only(left: kwidth(context)*0.02),
      width: kwidth(context),
      height: kheight(context)*0.25,
      decoration: BoxDecoration(
        color: bgTaskCardColor(data.isRunning!, data.compelete!),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () async =>await detailsNotifBottomShet(context, data,_stopWatchTimer,context),
        child: Row(
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
                    padding:  EdgeInsets.symmetric(horizontal: kwidth(context)*0.044, vertical: kheight(context)*0.0055),
                    child: Text(data.priority == 1 ? 'High' : 'medium',style: TextStyle(
                      fontSize: kwidth(context)*0.024,fontWeight: FontWeight.w600
                    ),),
                  ),
                ),
                
                //! title
                SizedBox(
                  height: kheight(context)*0.09,
                  width: kwidth(context)*0.7,
                  child: Text(
                    data.title!.length > 40 ?
                      '${data.title!.substring(0,40)} ...'
                      :data.title ?? '',
                    style: TextStyle( fontSize: kwidth(context)*0.05, fontWeight: FontWeight.w600 ),
                  ),
                ),

                
                //! date
                Row(
                  children: [
                    Icon(Icons.calendar_month_outlined,size: kwidth(context)*0.03,),
                    const SizedBox(width: 3,),
                    Text(data.date ?? '',style: TextStyle(
                      color: Colors.black,
                      fontSize: kwidth(context)*0.025,
                      fontWeight: FontWeight.w500
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
                              ? Text(data.diffTime?.split('.')[0] ?? 'CopT',style: textStyle(context),)
                              : data.isRunning!
                                ? streamDiffWidget(_stopWatchTimer)
                                : Text(data.diffTime?.split('.')[0] ?? 'CopT',style: textStyle(context)) ),

                              
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
            Container(
              height: kheight(context)*0.25,
              width: kwidth(context)*0.13,  
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: data.compelete! ? kLightGreenColor : data.isRunning! 
                  ?  kLightBlueColor
                  :  kLightRedColor,
              ),
              child: Center(
                child: Text(
                  data.compelete! ? 'Done \n  ✅' : data.isRunning! ? 'Run \n  🏃' : 'Stop \n  🛑',
                  style: TextStyle(fontWeight: FontWeight.w700,),
                ), ),
            )
          
          ],
        ),
      ),
    );
  }

  
}

TextStyle textStyle(BuildContext context)=> TextStyle(fontSize: kwidth(context)*0.025);
Widget streamDiffWidget(StopWatchTimer stopWatchTimer)=> StreamBuilder<int>(
  stream: stopWatchTimer.rawTime, 
  builder: (context, snapshot) {
    final value = snapshot.data;
    final displayTime = StopWatchTimer.getDisplayTime(value ?? 0);
    return Text(displayTime.split('.')[0],style: textStyle(context));
  },);

Widget startEndTimeWidget(BuildContext context,String? title,bool isStart)=> Row(
  children: [
    Icon(isStart ? Icons.hourglass_top_outlined : Icons.hourglass_bottom,size: kwidth(context)*0.03,),
    Text(title?.split(' ').last.split('.').first == null 
      ? isStart 
        ? 'start time' 
        : 'endTime'
      :title!.split(' ').last.split('.').first
      ,style: TextStyle( fontSize: kwidth(context)*0.026 ,fontWeight: FontWeight.w300),)
  ],
);