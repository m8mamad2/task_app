import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/widget/shimmer_widget.dart';

Widget ProfileScreenMobileShimmer(BuildContext context)=> Padding(
  padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.045),
  child: Column(
    children: [
      SizedBox(
        width: kwidth(context)*0.3,
        height: kheight(context)*0.155,
        child: shimmer(
        child: CircleAvatar( 
          radius: kwidth(context)*0.18,
          backgroundColor: kMainColor,),),),
      Padding(
        padding: EdgeInsets.symmetric(vertical: kheight(context)*0.015),
        child: shimmer(
          child: Container(
            height: kheight(context)*0.03,
            width: kwidth(context)*0.4,
            color: kMainColor,
          ),
        ),
      ),
      SizedBox(height: kheight(context)*0.02,),
      ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) => shimmer(
          child: Container(
            width: kwidth(context),
            height: kheight(context)*0.07,
            margin: EdgeInsets.symmetric(vertical: kheight(context)*0.01),
            padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.04),
            decoration: BoxDecoration( 
              borderRadius: BorderRadius.circular(15),
              color: kFourthColor ),),
        ))
    ],
  ),
);