import 'package:flutter/material.dart';

class CustomTextSmall extends StatelessWidget {
  Color textColor;
  final String text;
  double Size;
  FontWeight fontWeighttext;
  double heighttext;
  CustomTextSmall({
    Key? key,
    this.textColor=const Color(0xFFccc7c5),
    required this.text,
    this.Size = 15,
    this.heighttext=1.3,
    this.fontWeighttext=FontWeight.w700,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        height: heighttext,
        color: textColor,
        fontSize: Size,
        fontFamily: "Playfair",
        fontWeight: fontWeighttext,
      ),
    );
  }
}
