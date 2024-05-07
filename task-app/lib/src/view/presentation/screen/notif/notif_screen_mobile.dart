import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/bottom_shets.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/widget/empty_widget.dart';
import 'package:taskapp/src/core/widget/error_widget.dart';
import 'package:taskapp/src/core/widget/main_appbar.dart';
import 'package:taskapp/src/core/widget/shimmer/notif_screen_shimmder.dart';
import 'package:taskapp/src/view/data/model/notif_model.dart';
import 'package:taskapp/src/view/presentation/bloc/notif_bloc/notif_bloc.dart';
import 'package:taskapp/src/view/presentation/widget/notif/notif_card_widget.dart';

NotifModel fakeNotifModel = NotifModel(1, 'Calling ME For Some Reason', 'ok Thas sound WOsome', 1, 1, 1,'23:00');

class NotifScreenMobile extends StatefulWidget {
  const NotifScreenMobile({super.key});

  @override
  State<NotifScreenMobile> createState() => _NotifScreenMobileState();
}
class _NotifScreenMobileState extends State<NotifScreenMobile> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(size: Size( kwidth(context),kheight(context)*0.1),isHomeScreenMobile: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.045),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Notification 🔔',style: TextStyle(color: kFourthColor,fontSize: kwidth(context)*0.065,fontWeight: FontWeight.bold),),
              Padding(
                padding: EdgeInsets.symmetric(vertical: kheight(context)*0.03),
                child: Text('You can set a notification so that we will notify you at that time',style: TextStyle(color: kFourthColor,fontWeight: FontWeight.w300,fontSize: kwidth(context)*0.034)),
              ),
              BlocBuilder<NotifBloc,NotifState>(
                builder: (context, state) {
                  if(state is LoadingNotifState)return NotifScreenMobileShimmer(context);
                  if(state is SuccessNotifState){
                    final List<NotifModel>? data = state.data;
                    return data == null || data.isEmpty 
                      ? Container(
                          margin: EdgeInsets.only(top: kheight(context)*0.06),
                          child: emptyWidget(context, 'No Notif Set',kheight(context)*0.1,kheight(context)*0.25))
                      : ListView.builder(
                          itemCount: data.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => 
                            notifCardWidget(context, data[index],index) ,);
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
        width: kwidth(context)*0.15,
        child: FittedBox(
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            autofocus: true,
            onPressed: ()async=> addNotifBottomshet(context),
            backgroundColor: kFourthColor,
            child: const Icon(Icons.notification_add_outlined,color: kMainColor,)),
        ),
      ),
    );
  }
}



