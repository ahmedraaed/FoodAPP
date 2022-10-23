import 'package:flutter/material.dart';
import 'package:foodapp/utiles/dimansions.dart';
import 'package:foodapp/widgets/custom_text_small.dart';

class IconAndText extends StatelessWidget {
 final IconData icon;
  final Color IconColor;
  final String text;
   IconAndText({Key? key, required this.icon, required this.IconColor, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: IconColor,size: Dimensions.iconSize20),
        SizedBox(width: Dimensions.width5,),
        CustomTextSmall(text: text,Size: Dimensions.height10,),


      ],
    );
  }
}
