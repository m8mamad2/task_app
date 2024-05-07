
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/extenstion/navigation_extension.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/styles.dart';
import 'package:taskapp/src/core/widget/error_widget.dart';
import 'package:taskapp/src/view/data/model/notif_model.dart';
import 'package:taskapp/src/view/presentation/bloc/notif_bloc/notif_bloc.dart';

Widget notifCardWidgetDesktop(BuildContext context,NotifModel data,int index)=> Container(
  margin: EdgeInsets.symmetric(vertical: kheight(context)*0.01),
  padding: EdgeInsets.symmetric(
    vertical: kheight(context)*0.04,
    horizontal: kwidth(context)*0.01,),
  decoration: BoxDecoration( borderRadius: BorderRadius.circular(15), color: kSecondColor ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        data.title!.length > 40
          ?'${data.title!.substring(0, 40)} ...'
          : data.title!,
        style: const TextStyle(color: kFourthColor, fontSize: 26),),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          data.dec!.length > 40
            ? '${data.dec!.substring(0,40)}...'
            :data.dec!,
          style:  const TextStyle(color: Colors.grey,fontSize: 16)),
      ),
      const Spacer(),
      InkWell(
        onTap:() => deleteNotif(context, index, data.id!),
        // onTap: ()=> context.read<NotifBloc>().add(DeleteNotifEvent(index, data.id!,context)),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius:  BorderRadius.all(Radius.circular(20)),
            color: kLightGreenColor,
          ),
          width: kwidth(context),
          child: const Padding(
            padding:  EdgeInsets.symmetric(vertical: 9),
            child: Center(child: Text('Delete Notification')),
          )),
      )
    ],
  ),
);



Future deleteNotif(BuildContext context,int index, int id)async=> await showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        backgroundColor: kSecondColor,
        shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.all( Radius.circular(20)) ),
        content: Container(
          width: kwidth(context)*0.45,
          height: kheight(context)*0.24,
          decoration: const  BoxDecoration(
            border: Border(top: BorderSide(color: kThiredColor)),
            color: kMainColor,
            borderRadius: BorderRadius.all( Radius.circular(20))
          ),
          child: Form(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.04),
              child: Column(
                children: [
        
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: kheight(context)*0.03),
                    child:const Text('Are you Shure You want Delete This Notification? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),)),
                  
                  const Spacer(),
                
                  Padding(
                    padding: EdgeInsets.only(bottom: kheight(context)*0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Expanded(
                          child: ElevatedButton(
                            onPressed: ()=> context.navigateBack(context), 
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              minimumSize: Size(kwidth(context)*0.43, kheight(context)*0.055),
                              backgroundColor: kThiredColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6),)
                            ),
                            child: const Text('Cancel',style: TextStyle(color: kFourthColor),)),
                        ),
                        
                        SizedBox(width: kwidth(context)*0.02,),
                        
                        Expanded(
                          child: BlocBuilder<NotifBloc,NotifState>(
                            builder: (context, state) {
                              
                              onTap()=> context.read<NotifBloc>().add(DeleteNotifEvent(index, id,context));
                                  
                              if(state is LoadingNotifState) return loadingButton(context);
                              if(state is InitialNotifState) return ElevatedButton( onPressed: onTap, style: deleteButtonStyle(context),  child: const Text('Ok', style: TextStyle(color: Colors.white),),);
                              if(state is SuccessNotifState)  return ElevatedButton( onPressed: onTap, style:deleteButtonStyle(context),  child: const Text('Ok',  style: TextStyle(color: Colors.white),),);
                              if(state is FailNotifState)    return ElevatedButton( onPressed: onTap, style: deleteButtonStyle(context,), child: const Text('Fail ! Try Again',style: TextStyle(color: Colors.white),),);
                              return Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
               
                ],
              ),
            )),
        ),
      );
    },);