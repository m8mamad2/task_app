import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/borders.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/widget/empty_widget.dart';
import 'package:taskapp/src/core/widget/error_widget.dart';
import 'package:taskapp/src/core/widget/main_appbar.dart';
import 'package:taskapp/src/core/widget/shimmer/home_screen_shimmer.dart';
import 'package:taskapp/src/core/widget/shimmer/list_view_card_widget.dart';
import 'package:taskapp/src/view/data/model/task_model.dart';
import 'package:taskapp/src/view/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:taskapp/src/view/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:taskapp/src/view/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:taskapp/src/view/presentation/widget/home/card/home_card_widget_desktop.dart';
import 'package:taskapp/src/view/presentation/widget/home/card/home_card_widget_mobile.dart';
import 'package:taskapp/src/view/presentation/widget/home/home_task_counter_text_animation_widget.dart';

class HomeScreenDesktop extends StatefulWidget {
  const HomeScreenDesktop({super.key});

  @override
  State<HomeScreenDesktop> createState() => _HomeScreenDesktopState();
}
class _HomeScreenDesktopState extends State<HomeScreenDesktop> {
  
  final TextEditingController controller = TextEditingController();
  bool isSearchState = false;
  bool searchFakeLoading = false;
  String date = DateTime.now().toString().split(' ')[0];

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(GetTaskToDayEvent(date));
  }



  Future requestForSearch(String query)async{
    
    setState(() {
      if(query.isNotEmpty) {  isSearchState = true; }
      else {  isSearchState = false;  }
    });

    if(query.length < 3 && query.isNotEmpty){ setState(()=> searchFakeLoading = true); }
    else if(query.isNotEmpty && query.length >= 3) { 
      setState(() => searchFakeLoading = false);
      context.read<SearchBloc>().add(SearchReqEvent(query)); }
    else { setState(() => searchFakeLoading = false); }  //? fake loading -> wordk between 0 - 3

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kheight(context)*0.07,
        bottom: PreferredSize(
          preferredSize: Size(kwidth(context), 1), 
          child: Container(height: 1,width: kwidth(context),color: kSecondColor,)),
        
        title: SizedBox(
          width: 400,
          height: 42,
          child: TextFormField(
            controller: controller,
            onChanged: (value) => requestForSearch(value),
            style: const TextStyle(color: Colors.grey,fontSize: 15 ),
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: homeSearchBorderDesktop(kFourthColor),
              focusedBorder: homeSearchBorderDesktop(kThiredColor),
              suffixIcon: const Icon(Icons.search,color: Colors.grey,),
              hintText: 'Search Fro Tasks ',
              hintStyle: const TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 13)
            ),
          ),
        ),
      ),
      body: BlocBuilder<TaskBloc,TaskState>(
        builder: (context, state) {
          if(state is LoadingTaskState)return HomeScreenMobileShimmer(context);;
          if(state is SuccessTaskState){
            final List<TaskModel?>? data = state.taskToDayModel;
             return Padding(
                padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.013),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<UserBloc,UserState>(
                        builder: (context, state) {
                        if(state is LoadingUserState)return const CircularProgressIndicator(backgroundColor: Colors.amber,);
                        if(state is SucessUserState)  return Container(margin: const EdgeInsets.only(top: 18),child: Text('Hello ${state.data!.name ?? 'To You'} 👋', style: TextStyle( color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500 ),));
                        if(state is FailUserState)return const CircularProgressIndicator(color: Colors.red,);
                        return const CircularProgressIndicator(color: Colors.green,);
                        },
                      ),
                     
                      homeTaskCounterTextAnimationWidget(context,data?.length ?? 0,10, true),
                     
                     
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: kheight(context)*0.03),
                        child: const Text('Tasks',style: TextStyle(color: kFourthColor,fontSize: 30,fontWeight: FontWeight.w400),),
                      ),
                      isSearchState 
                        ? searchFakeLoading  
                          ? listViewCardHomeWidget(context)
                          : BlocBuilder<SearchBloc,SearchState>(
                              builder: (context, state) {
                                if(state is LoadingSearchState) return listViewCardHomeWidget(context);
                                if(state is SuccessSearchState){
                                  return state.searchTaskModels != null && state.searchTaskModels!.isNotEmpty 
                                    ?GridView.builder(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 40,
                                        crossAxisCount: crossAxis(context)
                                      ),
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: state.searchTaskModels?.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => CardTaskWidgetDesktop(data: state.searchTaskModels![index]!) )
                                      // ? ListView.builder(
                                      //     physics: const NeverScrollableScrollPhysics(),
                                      //     itemCount: state.searchTaskModels?.length,
                                      //     shrinkWrap: true,
                                      //     itemBuilder: (context, index) => CardTaskWidgetMobile(data: state.searchTaskModels![index]!) )
                                      : emptyWidgetDesktop(context, 'Not Task For This Day',kheight(context)*0.1,kheight(context)*0.3);
                                }
                                if(state is FailSearchState)return Text(state.error,style: TextStyle(color: Colors.white),);
                                return Container();
                              },
                          )
                        
                        : data == null || data.isEmpty 
                          ? emptyWidgetDesktop(context, 'Not Task For ToDay',kheight(context)*0.2 ,kheight(context)*0.3) 
                          : GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 40,
                                crossAxisCount: crossAxis(context)
                                ),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => CardTaskWidgetDesktop(data: data[index]!) )
                          
                    ],
                  ),
                ),
              );
          }
          if(state is FailTaskState)return Center(child: errorWidget(context, state.data, kheight(context)*0.2, kheight(context)*0.23,()=> context.read<TaskBloc>().add(GetTaskFromDateEvent(date, date))));
          return const Center(child: CircularProgressIndicator(color: Colors.red),);
        },
      ),
    );
  }
}



  //?  Gridview cross Axis for Responsive
  int crossAxis(BuildContext context){
    
    switch(kwidth(context)){
      case > 1553: return 4;
      case < 1553 && > 1100 :return 3;
      case < 1120 : return 2;
      default: return 3;
    }

  }
