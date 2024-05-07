import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/icons.dart';
import 'package:taskapp/src/core/images.dart';
import 'package:taskapp/src/core/keys.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/view/presentation/bloc/notif_bloc/notif_bloc.dart';
import 'package:taskapp/src/view/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:taskapp/src/view/presentation/screen/add_task_screen.dart';
import 'package:taskapp/src/view/presentation/screen/calender/calender_screen_desktop.dart';
import 'package:taskapp/src/view/presentation/screen/home/home_screen_desktop.dart';
import 'package:taskapp/src/view/presentation/screen/notif/notif_screen_desktop.dart';
import 'package:taskapp/src/view/presentation/screen/profile/profile_screen_desktop.dart';

class BottomNavigationBarWidgetDesktop extends StatefulWidget {
  final int? selected;
  const BottomNavigationBarWidgetDesktop({super.key,this.selected});

  @override
  State<BottomNavigationBarWidgetDesktop> createState() => _BottomNavigationBarWidgetDesktopState();
}
class _BottomNavigationBarWidgetDesktopState extends State<BottomNavigationBarWidgetDesktop> {

  final pages = const [ HomeScreenDesktop(), CalenderScreenDesktop(), HomeScreenDesktop() ,NotifScreenDesktop(), ProfileScreenDesktop() ];
  final List<String> titles = ['Home','Calender','Add Task','Notification','Profile',];
  late int _selected;
  
  @override
  void initState() {
    super.initState();
    _selected = widget.selected ?? 0;
    context.read<UserBloc>().add(AddUserToDBEvent());
    context.read<UserBloc>().add(GetUserEvent());
    context.read<NotifBloc>().add(GetAllNotifEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Keys.bottomNavigationShet,
      body: Container(
        decoration: const BoxDecoration(
          border: BorderDirectional(top: BorderSide(width: 8,color: kThiredColor))
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: kheight(context),
                decoration: const BoxDecoration(  
                  border: BorderDirectional(end: BorderSide(color: kSecondColor)) ),
                child: Column(
                  children: [
                    Container(
                          decoration:const BoxDecoration( border: BorderDirectional(bottom:BorderSide(color: kSecondColor) )),
                          child:const Padding(
                            padding: EdgeInsets.only(left: 20,bottom: 15,top: 15),
                            child: Row(
                              children: [
                                Text('TASK',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w900),),
                                Icon(Icons.check,size: 40,color: kThiredColor,),
                              ],
                            ),
                          ),
                        ),
                    Container(
                      margin: EdgeInsets.only(top: kheight(context)*0.05),
                      width: kwidth(context)*0.22,
                      height: kheight(context)*0.66,
                      child: NavigationRail(
                        selectedIndex: _selected,
                        onDestinationSelected: (value) async => value == 2 
                          ? await addTaskDialog(context)
                          : setState(()=> _selected = value) ,
                        labelType: NavigationRailLabelType.none,
                        backgroundColor: kMainColor,
                        extended: false,
                        minWidth: kwidth(context)*0.21,
                        useIndicator: false,
                        destinations: List.generate(5, (index) => 
                          NavigationRailDestination(
                            icon: Container(
                              width: kwidth(context),
                              height: 50,
                              decoration: BoxDecoration(
                                color: _selected == index 
                                  ? const Color(0xff2ee38c)
                                  : kMainColor,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              margin: const EdgeInsets.only(left: 20),
                              child: Row(
                              children: [
                                Icon(
                                  kBottomNavigationBarIconsOutline[index],
                                  color: _selected == index ? Colors.white : Colors.grey,
                                  size: 24,),
                                const SizedBox(width: 11,),
                                Expanded(
                                  child: Text(
                                    titles[index], 
                                    style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color:_selected == index ? Colors.white : Colors.grey),),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: _selected == index ? Colors.white : Colors.grey)
                              ],
                                                  ), 
                            ),
                            label: const SizedBox.shrink())),
                        ),
                    ),
                    BlocBuilder<UserBloc,UserState>(
                      builder: (context, state) {
                        if(state is LoadingUserState)return const CircularProgressIndicator(color: Colors.amber,);
                        if(state is SucessUserState){
                          return Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 10,left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: ()=>context.read<UserBloc>().add(LogoutUserEvent(context)),
                                    child: Container(
                                      width: kwidth(context),
                                      margin: const EdgeInsets.only(left: 7,bottom: 15),
                                      height: 50,
                                      decoration: BoxDecoration(color:kMainColor,borderRadius: BorderRadius.circular(10)),
                                      child: const Row(
                                      children: [
                                        Icon(Icons.logout_outlined,color: Colors.grey,size: 24,),
                                        SizedBox(width: 11,),
                                        Expanded(
                                          child: Text(
                                            'logout', 
                                            style: TextStyle(fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color:Colors.grey),),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          color: Colors.grey)
                                      ],
                                      ), 
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        child: CircleAvatar(
                                          backgroundColor: kMainColor,
                                          radius: 30,
                                          backgroundImage: AssetImage( finalImage(state.data!.profileImage ?? 1)), 
                                      )),
                                      const SizedBox(width: 5,),
                                      Expanded(child: Text(state.data?.name ?? '', style: const TextStyle(color: Colors.white),))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        if(state is FailUserState)return const CircularProgressIndicator(color: Colors.red,);
                        return const CircularProgressIndicator(color: Colors.purple,);
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            Expanded(
              flex: 5,
              child: IndexedStack(index: _selected, children: pages)),
            
          ],
        ),
      ),
      // body: IndexedStack( index: _selected, children: pages, ),
      // bottomNavigationBar: SizedBox(
      //   height: kheight(context)*0.1,
      //   child: Stack(
      //     children: [
      //       Container(width: kwidth(context)*0.5,height: kheight(context),color: Colors.red,)
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     decoration: const BoxDecoration(
            //       border: Border(top: BorderSide(color: Colors.white,width: 0.1))
            //     ),
            //     margin: EdgeInsets.only(bottom: kheight(context)*0.01),
            //     child: BottomNavigationBar(
            //       currentIndex: _selected,
            //       backgroundColor: kMainColor,
            //       onTap: (value) => setState(()=> _selected = value),
            //       type: BottomNavigationBarType.fixed,
            //       showSelectedLabels: false,
            //       selectedFontSize: 0,
            //       showUnselectedLabels: false,
            //       useLegacyColorScheme: false,
            //       items:  List.generate(5, (index) => 
            //         BottomNavigationBarItem(
            //           activeIcon: Column(
            //             children: [
            //               Container(
            //                 margin: const EdgeInsets.only(bottom: 5),
            //                 width: kwidth(context)*0.1,
            //                 height: 2,
            //                 color: index == 2 ? Colors.transparent :kThiredColor,
            //               ),
            //               index ==  2 ? const SizedBox.shrink() : Icon(kBottomNavigationBarIcons[index],color: kThiredColor,size: kwidth(context)*0.07),
            //             ],
            //           ),
            //           label: '',
            //           icon:index ==  2
            //             ? const SizedBox.shrink()
            //             : Icon(
            //                 kBottomNavigationBarIconsOutline[index],
            //                 size: kwidth(context)*0.07,
            //                 color: kFourthColor, ))),
            //     ),
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.center,
            //   child: Padding(
            //     padding: const EdgeInsets.only(bottom: 20),
            //     child: InkWell(
            //       onTap: () async => await addTaskBottomShet(context),
            //       child: Container(
            //         width: kwidth(context)*0.15,
            //         height: kheight(context)*0.072,
            //         decoration: BoxDecoration(
            //           color: kThiredColor,
            //           borderRadius: BorderRadius.circular(18)
            //         ),
            //         child: Icon(Icons.add,size: kwidth(context)*0.066,),
            //       ),
            //     ),
            //   ),
            // )
      //     ],
      //   ),
      // ),
    
    );
  }
}

