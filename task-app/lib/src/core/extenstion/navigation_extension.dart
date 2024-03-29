import 'package:flutter/material.dart';

extension Navigation on BuildContext{
  Future<void> navigate(BuildContext context,Widget widget )=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget,));
  void navigateBack(BuildContext context)=>Navigator.of(context).pop();
}