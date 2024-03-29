import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/widget/shimmer_widget.dart';

Widget notifScreenShimmer(BuildContext context)=> ListView.builder(
  itemCount: 7,
  shrinkWrap: true,
  physics: const BouncingScrollPhysics(),
  itemBuilder: (context, index) => shimmer(child: Container(
    margin: EdgeInsets.symmetric(vertical: kheight(context)*0.01),
    width: kwidth(context),
    height: kheight(context)*0.09,
    padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.05,vertical: kheight(context)*0.011),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: kMainColor
    ),),));