import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/extenstion/navigation_extension.dart';
import 'package:taskapp/src/core/sizes.dart';
import 'package:taskapp/src/core/styles.dart';

Future errorBottomShet(BuildContext context,String text) async => await showModalBottomSheet(
  context: context, 
  builder: (context) {
    return Container(
      width: kwidth(context),
      height: kheight(context)*0.4,
      decoration: const  BoxDecoration(
        border: Border(top: BorderSide(color: kThiredColor)),
        color: kMainColor,
        borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.04),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: kheight(context)*0.1),
              child: Text(text,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w800),)),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: kheight(context)*0.03),
              child: ElevatedButton(
                style: authButtonStyle(context,kThiredColor),
                onPressed: ()=> context.navigateBack(context),
                child: const Text('ok',style: TextStyle(color: Colors.black),),
              ),
            )
          ],
        ),
      ),
    );
  },);




Future errorDialog(BuildContext context,String text) async => await showDialog(
  context: context, 
  builder: (context) {
    return AlertDialog(
      backgroundColor: kSecondColor,
      shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all( Radius.circular(20)) ),
      content: Container(
        width: kwidth(context)*0.4,
        height: kheight(context)*0.4,
        decoration: const  BoxDecoration(
          border: Border(top: BorderSide(color: kThiredColor)),
          color: kMainColor,
          borderRadius: BorderRadius.all( Radius.circular(20))
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kwidth(context)*0.04),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(text,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w800),)),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: kheight(context)*0.03),
                child: ElevatedButton(
                  style: authButtonStyle(context,kThiredColor),
                  onPressed: ()=> context.navigateBack(context),
                  child: const Text('ok',style: TextStyle(color: Colors.black),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  },);