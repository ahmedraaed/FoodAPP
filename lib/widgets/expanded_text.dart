import 'package:flutter/material.dart';
import 'package:foodapp/utiles/app_colors.dart';
import 'package:foodapp/utiles/dimansions.dart';
import 'package:foodapp/widgets/custom_text_small.dart';

class ExpandedText extends StatefulWidget {
  String text;
   ExpandedText({Key? key,required this.text}) : super(key: key);

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  late String firstText;
  late String secendText;

  bool hideText=true;

  double heightText=Dimensions.heightScreen/6.88;


  void initState()
  {
    super.initState();
    if(widget.text.length>heightText)
      {
        firstText=widget.text.substring(0,heightText.toInt());
        secendText=widget.text.substring(heightText.toInt()+1,widget.text.length);

      }else
        {
          firstText=widget.text;
          secendText="";
        }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secendText.isEmpty?CustomTextSmall(text: firstText):Column(
        children: [
          CustomTextSmall(text: hideText?  firstText+"...":firstText+secendText,heighttext: 1.8),
          InkWell(
            onTap: (){
              setState((){
                hideText=!hideText;
              });

            },
            child: Row(
              children: [
                CustomTextSmall(text:hideText? "Show More":"Show Less"),
                SizedBox(height: Dimensions.height50,),
                Icon(hideText?Icons.keyboard_arrow_down:Icons.keyboard_arrow_up,color: AppColors.mainColor,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
