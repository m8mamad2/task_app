import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/widget/shimmer_widget.dart';

Widget calenderScreenShimmer(BuildContext context)=> Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    shimmer(
      child: Container(
        margin: EdgeInsets.only(top: kheight(context)*0.04,bottom: kheight(context)*0.02),
        height: kheight(context)*0.03,
        width: kwidth(context)*0.55,
        color: kMainColor,
      )),
    shimmer(child: Container(
      width: kwidth(context),
      height: kheight(context)*0.25,color: Colors.white,
    )),
    shimmer(
      child: Container(
      margin: EdgeInsets.only(bottom: 10,top: kheight(context)*0.04),
      width:kwidth(context)*0.2,
      height: kheight(context)*0.03,
      color: kMainColor,
    )),
    ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => shimmer(
            child: Container(
            margin: EdgeInsets.symmetric(vertical: kheight(context)*0.008),
            padding: EdgeInsets.only(left: kwidth(context)*0.02),
            width: kwidth(context),
            height: kheight(context)*0.25,
            decoration: BoxDecoration( color: kThiredColor, borderRadius: BorderRadius.circular(20), ),
          ))
        )


  ],
);