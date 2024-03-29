import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/widget/shimmer_widget.dart';

Widget homeScreenShimmer(BuildContext context)=>Padding(
  padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.045),
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shimmer(child: Container( width: kwidth(context)*0.28, height: kheight(context)*0.025, color: Colors.white, )),
        shimmer(
          child: Container(
            margin:EdgeInsets.symmetric(vertical: kheight(context)*0.02,),
            width: kwidth(context),
            height: kheight(context)*0.048,
            color: kMainColor
          ),
        ),
        shimmer(child: Container( height: kheight(context)*0.06, width: kwidth(context), color: Colors.white, )),
        shimmer(child: Container( margin: EdgeInsets.symmetric(vertical: kheight(context)*0.03),width: kwidth(context)*0.18, height: kheight(context)*0.025, color: Colors.white, )),
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
    ),
  ),
);