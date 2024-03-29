import 'package:flutter/material.dart';

const Color kMainColor = Color(0xff0a0a0a);//0xff181a1b
const Color kSecondColor = Color(0xff1d2021);

const Color kThiredColor = Color(0xff2ee38c); //fd4057
const Color kFourthColor = Colors.white;

// ! Color For Task Cards
const Color kBlueColor = Color(0xff186ade);
const Color kRedColor = Color(0xffd32f2f);

const Color kLightGreenColor = Color(0xffe1ecc8);
const Color kLightBlueColor = Color(0xffadccf7);
const Color kLightRedColor = Color(0xffe7c6c8);
// 0xfffd4057
// 0xffd2b3fd
// kThiredColor

// 0xffbb86fc // بنفش
// 0xff03dac6 // سبر آبی
// 0xfff66934//orange  //cc
// 0xff2554aa


Color bgTaskCardColor(bool isRunning, bool isCompelte){
    return isCompelte 
      ? kThiredColor
      : isRunning 
        ? kBlueColor
        : kRedColor;
  } 