import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';

ThemeData theme()=>ThemeData( 
  colorSchemeSeed: kThiredColor,
  scaffoldBackgroundColor: kMainColor,
  appBarTheme:const AppBarTheme( backgroundColor: kMainColor, foregroundColor: kMainColor, ),
);