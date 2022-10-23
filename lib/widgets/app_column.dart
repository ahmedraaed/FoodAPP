import 'package:flutter/material.dart';

import '../utiles/app_colors.dart';
import '../utiles/dimansions.dart';
import 'custom_text.dart';
import 'custom_text_small.dart';
import 'icon_text.dart';

class AppColumn extends StatelessWidget {
  String text;
   AppColumn({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: text,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                      (index) => Icon(
                    Icons.star,
                    color: AppColors.mainColor,
                    size: Dimensions.iconSize15,
                  )),
            ),
            SizedBox(
              width: Dimensions.height10,
            ),
            CustomTextSmall(text: "4.5", Size: 10),
            SizedBox(
              width: Dimensions.height10,
            ),
            CustomTextSmall(
              text: "1250",
              Size: 10,
            ),
            SizedBox(
              width: 5,
            ),
            CustomTextSmall(text: "Comments", Size: 10),
          ],
        ),
        SizedBox(
          height: Dimensions.height15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
                icon: Icons.circle,
                IconColor: AppColors.iconColor1,
                text: "Normal"),

            IconAndText(
                icon: Icons.location_on,
                IconColor: AppColors.mainColor,
                text: "1.5km"),

            IconAndText(
                icon: Icons.access_time_rounded,
                IconColor: AppColors.iconColor2,
                text: "2.30min"),
          ],
        ),
      ],
    );
  }
}
