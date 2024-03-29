
import 'package:flutter/material.dart';
import 'package:taskapp/src/core/bottom_shets.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/view/data/model/notif_model.dart';

Widget notifCardWidget(BuildContext context,NotifModel data,int index)=> InkWell(
  onTap: ()async=>await deleteNotifBottomshet(context, index, data.id!),
  child: Container(
    margin: EdgeInsets.symmetric(vertical: kheight(context)*0.01),
    width: kwidth(context),
    height: kheight(context)*0.09,
    padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.05,vertical: kheight(context)*0.011),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: kSecondColor
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          data.title!.length > 40
            ?'${data.title!.substring(0, 40)} ...'
            : data.title!,
          style: const TextStyle(color: kFourthColor),),
        const SizedBox(height: 2,),
        Text(
          data.dec!.length > 40
            ? '${data.dec!.substring(0,40)}...'
            :data.dec!,
          style:  const TextStyle(color: Colors.grey)),
      ],
    ),
  ),
);

