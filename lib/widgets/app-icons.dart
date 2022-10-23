import 'package:flutter/material.dart';

class AppIcons extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double sizeicon;
  final double sizebackground;

  const AppIcons({
    Key? key,
    required this.icon,
     this.iconColor=const Color(0xFF756d54),
     this.backgroundColor=const Color(0xFFfcf4e4),
    required this.sizeicon,
    required this.sizebackground
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizebackground,
      width: sizebackground,
      decoration:BoxDecoration(
        color:backgroundColor,
        borderRadius: BorderRadius.circular(sizebackground/2),
      ) ,
      child: Icon(icon,color: iconColor,size: sizeicon,),
    );
  }
}
