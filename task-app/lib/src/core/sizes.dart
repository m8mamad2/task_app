import 'dart:math';

import 'package:flutter/material.dart';

double kwidth(BuildContext context)=> MediaQuery.sizeOf(context).width;
double kheight(BuildContext context)=> MediaQuery.sizeOf(context).height;


double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
  final width = MediaQuery.of(context).size.width;
  double val = (width / 1400) * maxTextScaleFactor;
  return max(1, min(val, maxTextScaleFactor));
}
