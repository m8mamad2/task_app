import 'package:flutter/material.dart';
import 'package:taskapp/src/core/responsive.dart';
import 'package:taskapp/src/core/widget/bottomNavigationBarWidget/bottom_navigation_widget_desktop.dart';
import 'package:taskapp/src/core/widget/bottomNavigationBarWidget/bottom_navigation_widget_mobile.dart';
import 'package:taskapp/src/view/presentation/screen/auth/auth_screen_desktop.dart';
import 'package:taskapp/src/view/presentation/screen/auth/auth_screen_mobile.dart';

Widget loginResponsiveChoese()=>      const Responsive(desktop: LoginScreenDesktop(), tablet: LoginScreenDesktop(), mobile: LoginScreenMobile());
Widget bottomNavigationBarChoose() => const Responsive(desktop: BottomNavigationBarWidgetDesktop(), tablet: BottomNavigationBarWidgetDesktop(), mobile: BottomNavigationBarWidgetMobile());