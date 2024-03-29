import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';


Widget profileCardWidget(BuildContext context,IconData icon, String title,VoidCallback onPress,bool hasValue,String? value,)=>InkWell(
  onTap: onPress,
  child: Container(
    width: kwidth(context),
    height: kheight(context)*0.07,
    margin: EdgeInsets.symmetric(vertical: kheight(context)*0.01),
    padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.04),
    decoration: BoxDecoration( 
      borderRadius: BorderRadius.circular(15),
      color: kSecondColor ),
    child: Row(
      children: [
        Icon(icon,color: kThiredColor,),
        const SizedBox(width: 10,),
        Text(title,style: const TextStyle(color: kFourthColor),),
        const Spacer(),
        
        hasValue
          ? Row(
              children: [
                Text(value ?? '',style: TextStyle(color: Colors.grey.shade600),),
                const SizedBox(width: 5,)
              ],
            )
          : const SizedBox.shrink(),
        const Icon(Icons.keyboard_arrow_right_rounded,color: kThiredColor,)
      ],
    ),
  ),
);
