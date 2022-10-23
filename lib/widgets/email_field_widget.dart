import 'package:flutter/material.dart';

import '../utiles/app_colors.dart';
import '../utiles/dimansions.dart';

class TextFromField extends StatelessWidget {
  TextEditingController textControll;
  String text;
  IconData icon;
  bool isObscure;
  TextFromField({
    Key? key,
    required this.textControll,
    required this.text,
    required this.icon,
    this.isObscure=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: Dimensions.height55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        boxShadow: [
          BoxShadow(
            offset: Offset(1,2),
            blurRadius: 7,
            color: Colors.black26,
          ),
        ],
      ),
      margin: EdgeInsets.only(left: Dimensions.width35,right: Dimensions.width35),
      child: TextFormField(
        obscureText: isObscure,
        controller:textControll ,
        decoration: InputDecoration(
          prefixIcon: Icon(icon,color: AppColors.yellowColor),
          label: Text(text),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius20),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius20),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
        ),
      ),
    );
  }
}
