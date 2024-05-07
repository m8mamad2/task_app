

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:taskapp/src/core/colors.dart';
import 'package:taskapp/src/core/styles.dart';

loadingButton(BuildContext context) =>ElevatedButton( onPressed: (){}, style: authButtonStyle(context), child: const CircularProgressIndicator(),);
failButton(BuildContext context,VoidCallback loginOnTap) =>ElevatedButton( onPressed: loginOnTap, style: authButtonStyle(context,Colors.red), child: const Text('Fail ! Try Again',style: TextStyle(color: kFourthColor),),);

