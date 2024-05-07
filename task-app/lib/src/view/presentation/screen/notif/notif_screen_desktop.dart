import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/bottom_shets.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/keys.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/styles.dart';
import 'package:taskapp/src/core/utils/random_number.dart';
import 'package:taskapp/src/core/widget/empty_widget.dart';
import 'package:taskapp/src/core/widget/error_widget.dart';
import 'package:taskapp/src/core/widget/main_appbar.dart';
import 'package:taskapp/src/core/widget/shimmer/notif_screen_shimmder.dart';
import 'package:taskapp/src/core/widget/textfiedls.dart';
import 'package:taskapp/src/view/data/model/notif_model.dart';
import 'package:taskapp/src/view/presentation/bloc/notif_bloc/notif_bloc.dart';
import 'package:taskapp/src/view/presentation/widget/notif/notif_card_widget.dart';
import 'package:taskapp/src/view/presentation/widget/notif/notif_card_widget_desktop.dart';

class NotifScreenDesktop extends StatefulWidget {
  const NotifScreenDesktop({super.key});

  @override
  State<NotifScreenDesktop> createState() => _NotifScreenDesktopState();
}
class _NotifScreenDesktopState extends State<NotifScreenDesktop> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kheight(context)*0.07,
        bottom: PreferredSize(
          preferredSize: Size(kwidth(context), 1), 
          child: Container(height: 1,width: kwidth(context),color: kSecondColor,)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.013),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text('Your Notification 🔔',style: TextStyle(color: kFourthColor,fontSize: 35,fontWeight: FontWeight.bold),)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: kheight(context)*0.03),
                child: const Text('You can set a notification so that we will notify you at that time',style: TextStyle(color: kFourthColor,fontWeight: FontWeight.w300,fontSize: 22)),
              ),
              BlocBuilder<NotifBloc,NotifState>(
                builder: (context, state) {
                  if(state is LoadingNotifState)return NotifScreenMobileShimmer(context);
                  if(state is SuccessNotifState){
                    final List<NotifModel>? data = state.data;
                    return data == null || data.isEmpty 
                      ? Container(
                          margin: EdgeInsets.only(top: kheight(context)*0.06),
                          child: emptyWidgetDesktop(context, 'No Notif Set',kheight(context)*0.1,kheight(context)*0.25))
                      : GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 40,
                            crossAxisCount: crossAxis(context)
                            ),
                          itemCount: data.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => 
                            notifCardWidgetDesktop(context, data[index],index) ,);
                  }
                  if(state is FailNotifState)return errorWidget(context, state.error, kheight(context)*0.4, kheight(context)*0.4,(){});
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        child: FittedBox(
          child: FloatingActionButton.large(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            autofocus: true,
            onPressed: ()async=> addNotifDialog(context),
            backgroundColor: kFourthColor,
            child:const Icon(Icons.notification_add_outlined,color: kMainColor,)),
        ),
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






Future addNotifDialog(BuildContext context) async {
  
  loadingButton(BuildContext context) =>ElevatedButton( onPressed: (){}, style: authButtonStyle(context,kThiredColor), child: const CircularProgressIndicator(),);

  
  final key = Keys.addNotifBottomShetKey;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  Duration durationTimeFronNotif= Duration();

  return await showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.all( Radius.circular(20)) ),
        scrollable: false,
        backgroundColor: kMainColor,
        content: StatefulBuilder(
          builder: (context, setState) => Container(
              decoration: const  BoxDecoration(
                border: Border(top: BorderSide(color: kThiredColor)),
                color: kMainColor,
                borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              width: kwidth(context)*0.5,
              height: kheight(context)*0.5,
              child: Form(
                key: key,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.04),
                  child: Column(
                    children: [
                      bottomSheTextFiedlWidgetDesktop(context,'Title','start homeWork',titleController,false),
                      bottomSheTextFiedlWidgetDesktop(context,'Description','i should start from saving it',desController,false),
                      bottomSheTextFiedlWidgetDesktop(context,'Start Time','',timeController,true,()async{
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
                            if(state is SuccessNotifState)return ElevatedButton(onPressed: onTap,style: authButtonStyleDesktop(context,kThiredColor),child: Text('ok',style: TextStyle(color: Colors.black,fontSize: 20),),);
                            if(state is InitialNotifState)return ElevatedButton(onPressed: onTap,style: authButtonStyleDesktop(context,kThiredColor),child: Text('ok',style: TextStyle(color: Colors.black,fontSize: 20),),);
                            if(state is FailNotifState)return ElevatedButton( onPressed: onTap, style:  authButtonStyleDesktop(context,kRedColor), child: const Text('Fail ! Try Again',style: TextStyle(color: kFourthColor),),);
                            return Container();
                          },
                        ),
                      )
                    ],
                  ),
                )
              ),
            ),
        ),
      );
    },);

}
