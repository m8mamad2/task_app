import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';

Widget authButtonWidget(BuildContext context,String title,bool isOutline,VoidCallback onPress)=> ElevatedButton(
  onPressed: onPress,
  style:ElevatedButton.styleFrom(
    minimumSize: Size(kwidth(context)*0.9, kheight(context)*0.055),
    elevation: 0,
    backgroundColor: isOutline ? kMainColor : kFourthColor,
    shape: RoundedRectangleBorder( 
      side: isOutline ? const BorderSide(color: kFourthColor) : BorderSide.none,
      borderRadius: BorderRadius.circular(6))
  ), 
  child: Text(title,style: TextStyle(color: isOutline ? kFourthColor : kMainColor),),
);