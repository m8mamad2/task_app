import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/responsive.dart';
import 'package:taskapp/src/core/sizes.dart';

Widget authNavigateToAnotherScreen(BuildContext context, String title,String buttonTitle,VoidCallback changeAuthState)=> Padding(
      padding:  EdgeInsets.symmetric(vertical: kheight(context)*0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text( '$title  ',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize:Responsive.isLarge(context) ? kwidth(context)*0.01 : kwidth(context)*0.03),),
          InkWell(

            onTap: changeAuthState , 
            
            child: Text(
              buttonTitle,
              style: TextStyle( fontSize: Responsive.isLarge(context) ? kwidth(context)*0.01 : null, color: kThiredColor), ))
        ],
      ),
    );