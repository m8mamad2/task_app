// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget tablet;
  final Widget mobile;
  final Widget desktop;
  const Responsive({
    Key? key,
    required this.desktop,
    required this.tablet,
    required this.mobile,
  }) : super(key: key);

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context )=> MediaQuery.of(context).size.width >= 1100;

  static bool isLarge(BuildContext context)=> isDesktop(context) || isTablet(context);
  
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1100) return desktop;
      else if (constraints.maxWidth >= 650) return tablet;
      else return mobile;
    });
  }
}

