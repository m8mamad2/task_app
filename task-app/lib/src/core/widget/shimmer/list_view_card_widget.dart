import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/widget/shimmer_widget.dart';

Widget listViewCardHomeWidget(BuildContext context)=> ListView.builder(
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
);