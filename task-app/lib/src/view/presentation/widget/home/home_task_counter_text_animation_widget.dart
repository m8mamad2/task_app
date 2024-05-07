import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/sizes.dart';

Widget homeTaskCounterTextAnimationWidget(BuildContext context,int lenghtOfTasks,[double? height, bool? isDesktop])=> Padding(
  padding: EdgeInsets.symmetric(vertical: height ?? kheight(context)*0.02,),
  child: AnimatedTextKit(
    animatedTexts: [
      ColorizeAnimatedText(
        'You Are Have $lenghtOfTasks Tasks ToDay',
        textStyle:  TextStyle( fontWeight: FontWeight.bold,  fontSize: isDesktop ?? false ? 40 : 30),
        colors: [ kFourthColor, kThiredColor, ],
      ),
    ],
    repeatForever: true,
    isRepeatingAnimation: true,
    onTap: () { },
  ),
);


