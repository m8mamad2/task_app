import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/extenstion/navigation_extension.dart';
import 'package:taskapp/src/core/sizes.dart';

Widget authNavigateToAnotherScreen(BuildContext context, String title,String buttonTitle,Widget widget)=> Padding(
      padding:  EdgeInsets.symmetric(vertical: kheight(context)*0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text( '$title  ',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: kwidth(context)*0.03),),
          InkWell(onTap: ()=> context.navigate(context, widget), child: Text(buttonTitle,style: const TextStyle(color: kThiredColor), ))
        ],
      ),
    );