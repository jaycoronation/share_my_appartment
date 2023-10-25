import 'package:flutter/material.dart';

class PropertyTypeRes {
  String name ="";
  String bgColor = "";
  IconData itemIcon = Icons.arrow_forward;
  String iconColor = "";

  PropertyTypeRes({required String nameStatic, required String bgColorStatic, required IconData itemIconStatic,required String iconColorStatic}) {
    name = nameStatic;
    bgColor = bgColorStatic;
    itemIcon = itemIconStatic;
    iconColor = iconColorStatic;
  }
}
