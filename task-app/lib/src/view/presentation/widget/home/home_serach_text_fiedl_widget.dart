

import 'package:flutter/material.dart';
import 'package:taskapp/src/core/borders.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';


Widget homeSearchTextFieldWidget(BuildContext context,TextEditingController controller,VoidCallback reqForSearch)=>SizedBox(
  height: kheight(context)*0.06,
  child: TextFormField(
    controller: controller,
    style: const TextStyle(color: Colors.grey,fontSize: 15 ),
    decoration: InputDecoration(
      border: InputBorder.none,
      enabledBorder: homeSearchBorder(kFourthColor),
      focusedBorder: homeSearchBorder(kThiredColor),
      suffixIcon: const Icon(Icons.search,color: Colors.grey,),
      hintText: 'Search Fro Tasks ',
      hintStyle: TextStyle(color: Colors.grey,fontSize: kwidth(context)*0.03)
    ),
  ),
);
