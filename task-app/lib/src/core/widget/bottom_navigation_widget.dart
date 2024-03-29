import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/icons.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/widget/drawer.dart';
import 'package:taskapp/src/view/presentation/bloc/notif_bloc/notif_bloc.dart';
import 'package:taskapp/src/view/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:taskapp/src/view/presentation/screen/add_task_screen.dart';
import 'package:taskapp/src/view/presentation/screen/calender_screen.dart';
import 'package:taskapp/src/view/presentation/screen/home_screen.dart';
import 'package:taskapp/src/view/presentation/screen/notif_screen.dart';
import 'package:taskapp/src/view/presentation/screen/profile_screen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int? selected;
  const BottomNavigationBarWidget({super.key,this.selected});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}
class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {

  final pages = const [ HomeScreen(), CalenderScreen(), HomeScreen() ,NotifScreen(), ProfileScreen() ];
  final List<String> titles = ['Home','Calender','','Notification','Profile'];
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
      key: globalKey,
      drawer: const DrawerWidget(),
      body: IndexedStack( index: _selected, children: pages, ),
      bottomNavigationBar: SizedBox(
        height: kheight(context)*0.1,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white,width: 0.1))
                ),
                margin: EdgeInsets.only(bottom: kheight(context)*0.01),
                child: BottomNavigationBar(
                  currentIndex: _selected,
                  backgroundColor: kMainColor,
                  onTap: (value) => setState(()=> _selected = value),
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: false,
                  selectedFontSize: 0,
                  showUnselectedLabels: false,
                  useLegacyColorScheme: false,
                  items:  List.generate(5, (index) => 
                    BottomNavigationBarItem(
                      activeIcon: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            width: kwidth(context)*0.1,
                            height: 2,
                            color: index == 2 ? Colors.transparent :kThiredColor,
                          ),
                          index ==  2 ? const SizedBox.shrink() : Icon(kBottomNavigationBarIcons[index],color: kThiredColor,size: kwidth(context)*0.07),
                        ],
                      ),
                      label: '',
                      icon:index ==  2
                        ? const SizedBox.shrink()
                        : Icon(
                            kBottomNavigationBarIconsOutline[index],
                            size: kwidth(context)*0.07,
                            color: kFourthColor, ))),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: InkWell(
                  onTap: () async => await addTaskBottomShet(context),
                  child: Container(
                    width: kwidth(context)*0.15,
                    height: kheight(context)*0.072,
                    decoration: BoxDecoration(
                      color: kThiredColor,
                      borderRadius: BorderRadius.circular(18)
                    ),
                    child: Icon(Icons.add,size: kwidth(context)*0.066,),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


GlobalKey<ScaffoldState> globalKey = GlobalKey(); //? key for Open Drawer