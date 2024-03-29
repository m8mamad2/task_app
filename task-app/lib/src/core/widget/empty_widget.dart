import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';

Widget emptyWidget(BuildContext context,String text,double height,double marginFromTop)=> Center(
  child: Column(
    children: [
      Lottie.asset('assets/lottie/empty.json',height: height,width: kwidth(context)*0.7,fit: BoxFit.cover),
      SizedBox(height: marginFromTop,),
      Text(text,style: TextStyle(color: kFourthColor,fontWeight: FontWeight.bold,fontSize: kwidth(context)*0.04),),
      SizedBox(height: kheight(context)*0.06,)
    ],
  ),
);