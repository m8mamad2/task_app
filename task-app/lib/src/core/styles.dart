 
import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';

//! Button Style
ButtonStyle authButtonStyle(BuildContext context,[Color? color]) => ElevatedButton.styleFrom(
  minimumSize: Size(kwidth(context), kheight(context)*0.055),
  elevation: 0,
  backgroundColor: color ?? kFourthColor,
  shape: RoundedRectangleBorder( 
    side: BorderSide.none,
    borderRadius: BorderRadius.circular(6))
);

ButtonStyle deleteButtonStyle(BuildContext context)=> ElevatedButton.styleFrom(
  minimumSize: Size(kwidth(context)*0.43, kheight(context)*0.055),
  elevation: 0,
  backgroundColor: Colors.red,
    shape: RoundedRectangleBorder( 
    side: BorderSide.none,
    borderRadius: BorderRadius.circular(6))
);

ButtonStyle detailsButtonStyle(BuildContext context,bool isComplete,[Color? color]) => ElevatedButton.styleFrom(
  minimumSize: Size(isComplete ? kwidth(context)*0.3 : kwidth(context)*0.54, kheight(context)*0.055),
  elevation: 0,
  backgroundColor: color ?? kFourthColor,
  shape: RoundedRectangleBorder( 
    side: BorderSide.none,
    borderRadius: BorderRadius.circular(6))
);


//! TextStyles
TextStyle changeInfoBottomShetTextStyle(BuildContext context)=>TextStyle(color: Colors.black,fontSize: kwidth(context)*0.04);
TextStyle deleteButtonStyleTextStyle(BuildContext context)=>TextStyle(color: Colors.white,fontSize: kwidth(context)*0.04);