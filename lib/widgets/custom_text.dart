import 'package:flutter/material.dart';

import '../utiles/dimansions.dart';

class CustomText extends StatelessWidget {
  Color textColor;
  final String text;
  double sizetext;
  TextOverflow textOverflow;
  FontWeight fontWeighttext;
  CustomText({
    Key? key,
    this.textColor=const Color(0xFF332d2b),
    required this.text,
    this.sizetext = 0,
    this.textOverflow=TextOverflow.ellipsis,
    this.fontWeighttext=FontWeight.w400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      maxLines: 1,
      style: TextStyle(
         color: textColor,
        fontSize: sizetext ==0?Dimensions.font20:sizetext,
        fontFamily: "Playfair",
        fontWeight: fontWeighttext,
      ),
    );
  }
}
