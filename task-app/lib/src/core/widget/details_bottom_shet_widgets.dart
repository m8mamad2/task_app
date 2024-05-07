

import 'package:flutter/material.dart';
import 'package:taskapp/src/core/borders.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';

Widget oneColumnDetailsBottomShetWidget(BuildContext context,String title,TextEditingController controller,bool inRow,bool isDes,bool needSplit,[int? maxLine, int?minLine])=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.only(top: kheight(context)*0.02, bottom: kheight(context)*0.01),
      child: Text(
        title,
        style:const TextStyle(color: kFourthColor,fontWeight: FontWeight.w700 ),),
    ),
    SizedBox(
      height: isDes ? null : kheight(context)*0.06,
      width: inRow ? kwidth(context)*0.45 : kwidth(context),
      child: TextFormField(
        controller: controller,
        style: TextStyle( color: Colors.white,fontSize: kwidth(context)*0.035 ),
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle( color: Colors.grey,fontSize: kwidth(context)*0.03 ),
          enabledBorder: authBorder(kFourthColor),
          focusedBorder: authBorder(kFourthColor),
          focusedErrorBorder: authBorder(kRedColor),
          errorBorder: authBorder(kRedColor),
        ),
      ),
    )
  ],
);

Widget oneColumnForHourBottomShetWidget(BuildContext context,String title,String hintText,bool inRow,bool isDes,bool needSplit,){
 return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.only(top: kheight(context)*0.02, bottom: kheight(context)*0.01),
      child: Text(
        title,
        style:const TextStyle(color: kFourthColor,fontWeight: FontWeight.w700 ),),
    ),
    SizedBox(
      height: isDes ? null : kheight(context)*0.06,
      width: inRow ? kwidth(context)*0.45 : kwidth(context),
      child: TextFormField(
        readOnly: true,
        style: TextStyle( color: Colors.white,fontSize: kwidth(context)*0.035 ),
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText:  hintText.isNotEmpty ? hintText.split(" ")[1].split('.')[0].toString() : '',
          border: InputBorder.none,
          hintStyle: TextStyle( color: Colors.grey,fontSize: kwidth(context)*0.03 ),
          enabledBorder: authBorder(kFourthColor),
          focusedBorder: authBorder(kFourthColor),
          focusedErrorBorder: authBorder(kRedColor),
          errorBorder: authBorder(kRedColor),
        ),
      ),
    )
  ],
);
}
