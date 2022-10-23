import 'package:flutter/material.dart';
import 'package:foodapp/utiles/dimansions.dart';
import 'package:foodapp/widgets/app-icons.dart';
import 'package:foodapp/widgets/custom_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcons appIcons;
  CustomText customText;
  AccountWidget({Key? key,required this.appIcons,required this.customText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.height10,
        horizontal:Dimensions.width15 ),
      child: Row(
        children: [
          appIcons,
          SizedBox(width: Dimensions.width10,),
          customText,
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0,2),
            blurRadius: 3,
            color: Colors.black26
          ),
        ],
      ),
    );
  }
}
