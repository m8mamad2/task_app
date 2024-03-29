import 'package:flutter/material.dart';

authBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: BorderSide(color: color,width: 0.5,strokeAlign: 20,style: BorderStyle.solid),
  );

homeSearchBorder(Color color)=>OutlineInputBorder(
  borderRadius: BorderRadius.circular(6),
  borderSide: BorderSide(color: color,width: 1)
);
