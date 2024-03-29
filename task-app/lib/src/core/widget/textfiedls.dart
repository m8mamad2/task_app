import 'package:flutter/material.dart';
import 'package:taskapp/src/core/borders.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';


Widget bottomSheTextFiedlWidget(BuildContext context,String title,String lable,TextEditingController controller,bool isTime,[VoidCallback? onTap,bool? autoFocus])=> Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.only(top: kheight(context)*0.03, bottom: kheight(context)*0.01),
      child: Text(
        title,
        style: const TextStyle(color: kFourthColor,fontWeight: FontWeight.w700 ),),
    ),
    
    isTime 
      ? SizedBox(
          height: kheight(context)*0.06,
          child: TextFormField(
            controller: controller,
            readOnly: true,
            onTap: onTap,
            style: TextStyle( color: Colors.white,fontSize: kwidth(context)*0.035 ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: controller.text,
              hintStyle: TextStyle( color: Colors.grey,fontSize: kwidth(context)*0.03 ),
              enabledBorder: authBorder(kFourthColor),
              focusedBorder: authBorder(kFourthColor),
              focusedErrorBorder: authBorder(Colors.red),
              errorBorder: authBorder(Colors.red),
              ),
        ))
      
      : SizedBox(
          height: kheight(context)*0.06,
          child: TextFormField(
            controller: controller,
            style: TextStyle( color: Colors.white,fontSize: kwidth(context)*0.035 ),
            textInputAction: TextInputAction.next,
            autofocus: autoFocus ?? false,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: lable,
              hintStyle: TextStyle( color: Colors.grey,fontSize: kwidth(context)*0.03 ),
              enabledBorder: authBorder(kFourthColor),
              focusedBorder: authBorder(kFourthColor),
              focusedErrorBorder: authBorder(Colors.red),
              errorBorder: authBorder(Colors.red),
            ),
          ),
        )
    
  ],
);
     