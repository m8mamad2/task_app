import 'package:flutter/material.dart';
import 'package:taskapp/src/core/sizes.dart';

Future errorBottomShet(BuildContext context,String text) async => await showModalBottomSheet(
  context: context, 
  builder: (context) {
    return Container(
      width: kwidth(context),
      height: kheight(context)*0.4,
      color: Colors.amber,
      child: Center(child: Text(text)),
    );
  },);