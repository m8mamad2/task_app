

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/widget/empty_widget.dart';
import 'package:taskapp/src/core/widget/error_widget.dart';
import 'package:taskapp/src/core/widget/main_appbar.dart';
import 'package:taskapp/src/core/widget/shimmer/calender_screen_shimmder.dart';
import 'package:taskapp/src/view/data/model/task_model.dart';
import 'package:taskapp/src/view/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:taskapp/src/view/presentation/widget/calender/calender_char_widget_mobile.dart';
import 'package:taskapp/src/view/presentation/widget/home/card/home_card_widget_mobile.dart';

class CalenderScreenMobile extends StatefulWidget {
  const CalenderScreenMobile({super.key});

  @override
  State<CalenderScreenMobile> createState() => _CalenderScreenMobileState();
}

class _CalenderScreenMobileState extends State<CalenderScreenMobile> {

  String toDayDate = DateTime.now().toString().split(' ')[0];

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(GetTaskFromDateEvent(toDayDate,toDayDate));
  }
  
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: MainAppBarWidget(size: Size( kwidth(context),kheight(context)*0.1), isHomeScreenMobile: false),
       body: SingleChildScrollView(
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.01),
              child: EasyDateTimeLine(
                initialDate: DateTime.now(),
                onDateChange: (selectedDate) { 
                  String date = selectedDate.toString().split(' ')[0].trim();
                  context.read<TaskBloc>().add(GetTaskFromDateEvent(date,toDayDate));
                },
                activeColor: kThiredColor,
                headerProps:const EasyHeaderProps(
                  monthPickerType: MonthPickerType.switcher,
                  monthStyle: TextStyle(color: Colors.white),
                  selectedDateStyle: TextStyle(color: Colors.white)
                ),
                dayProps: const EasyDayProps(
                  todayHighlightStyle: TodayHighlightStyle.withBackground,
                  activeDayNumStyle: TextStyle(color: Colors.black),//? selected date
                  activeDayStrStyle: TextStyle(color: Colors.black),//? selected date
                  activeMothStrStyle: TextStyle(color: Colors.black),//? selected date
                  inactiveDayNumStyle: TextStyle(color: Colors.white),
                  borderColor: kThiredColor,
                  todayHighlightColor: Color(0xffE1ECC8),
                ),
              ),
            ),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: kwidth(context)*0.045),
              child: BlocBuilder<TaskBloc,TaskState>(
                
                
                builder: (context, state) {
                  if(state is LoadingTaskState)return calenderScreenShimmer(context);
                  if(state is SuccessTaskState){
                    final List<TaskModel?>? data = state.taskFromDateModels;
                    final List<Map<String,dynamic>>? chartData = state.charData;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: kheight(context)*0.04,bottom: kheight(context)*0.02),
                          child: Text('Your Activity Chart',style: TextStyle(color: kFourthColor,fontSize: kwidth(context)*0.065,fontWeight: FontWeight.bold),),
                        ),
                        LineChartSample2(values: chartData ?? [] ,),
                    
                        Padding(
                          padding: EdgeInsets.only(top: kheight(context)*0.03),
                          child: Text('Tasks',style: TextStyle(color: kFourthColor,fontSize: kwidth(context)*0.065,fontWeight: FontWeight.bold)),
                        ),
              
                        data == null || data.isEmpty 
                          ? emptyWidget(context,'There is No Task In This Date',kheight(context)*0.04,kheight(context)*0.3)
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => CardTaskWidgetMobile(data:data[index]!)),
                      ],
                    );
                  }
                  if(state is FailTaskState)return errorWidget(context, state.data, kheight(context)*0.3, kheight(context)*0.135,()=> context.read<TaskBloc>().add(GetTaskFromDateEvent(toDayDate, toDayDate)));
                  return Container();
                }
                
              ),
            )
          
          ],
         ),
       )
    );
  }
}

