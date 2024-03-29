import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taskapp/src/core/colors.dart';

Widget shimmer({required Widget child})=>Shimmer.fromColors(
  baseColor: kSecondColor,
  highlightColor: const Color(0xff5c5b53),
  child: child);