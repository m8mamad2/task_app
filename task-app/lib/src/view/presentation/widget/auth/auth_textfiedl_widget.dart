import 'package:flutter/material.dart';
import 'package:taskapp/src/core/borders.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';

Widget authTextfiedlWidget(
  BuildContext context,
  String title,
  TextEditingController controller,
  String lable,
  bool isPassowrd,
  bool isHide,
  String validatorType,
  VoidCallback onPressHide
  )=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(left: kwidth(context)*0.01,top: kheight(context)*0.03,bottom: kheight(context)*0.01),
            child: Text(title,
              style: TextStyle( color: kFourthColor, fontSize: kwidth(context)*0.03,fontWeight: FontWeight.w400 ),),
          ),
          SizedBox(
            height: kheight(context)*0.06,
            child: TextFormField(
              controller: controller,
              style: TextStyle( color: Colors.white,fontSize: kwidth(context)*0.035 ),
              obscureText: isPassowrd ? isHide ? true: false : false,
              textInputAction: TextInputAction.next,
              validator: (value) {
                  switch(validatorType){
                    case 'email':if(!(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!))) return 'Enter valid Email';break;
                    case 'phone': if(value!.isEmpty)return 'Enter someThing ...';break;
                    case 'password':if(value!.isEmpty)return 'Enter someThing ...' ;break;
                    default : return null;
                  }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: lable,
                hintStyle: TextStyle( color: Colors.grey,fontSize: kwidth(context)*0.03 ),
                suffixIcon: isPassowrd ? IconButton(onPressed: onPressHide, icon : isHide ? const Icon(Icons.visibility,color: kFourthColor,) : const Icon(Icons.visibility_off_rounded,color: kFourthColor)): null,
                enabledBorder: authBorder(kFourthColor),
                focusedBorder: authBorder(kFourthColor),
                focusedErrorBorder: authBorder(Colors.red),
                disabledBorder: authBorder(Colors.red),
                errorBorder: authBorder(Colors.red),
              ),
            ),
          )
        ],
      );

