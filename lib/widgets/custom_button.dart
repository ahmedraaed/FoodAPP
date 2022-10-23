import 'package:flutter/material.dart';
import 'package:foodapp/utiles/dimansions.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transperant;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? fontSize;
  final double radius;
  final IconData? icon;

   CustomButton({Key? key,
     this.onPressed,
     required this.buttonText,
      this.transperant=false,
     this.margin,
     this.width,
     this.height,
     this.fontSize,
     this.radius=5,
     this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle=TextButton.styleFrom(
      backgroundColor: onPressed==null?Theme.of(context).disabledColor:transperant?Colors.transparent:Theme.of(context).primaryColor,
      minimumSize: Size(width!=null?width!:Dimensions.widthScreen, height!=null?height!:50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
    return Center(
      child: SizedBox(
        width: width ?? Dimensions.widthScreen,
        height: height ?? 50,
        child: TextButton(
          onPressed: onPressed,
          style: buttonStyle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon!=null?Padding(
          padding: EdgeInsets.only(right: Dimensions.width10),
          child: Icon(icon,color: transperant?Theme.of(context).primaryColor:Theme.of(context).cardColor,),
        )
              :
          const SizedBox(),
              Text(
                buttonText,
                style: TextStyle(
                    fontSize:fontSize!=null?fontSize:Dimensions.font15 ,
                    color: transperant?Theme.of(context).primaryColor:Theme.of(context).cardColor,),)
              
            ],
          ),),
      ),
    );
  }
}
