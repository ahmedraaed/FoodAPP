import 'package:flutter/material.dart';
import 'package:get/get.dart';

void ShowSnakBar(String message,{bool isError=true,String title="Error",Color color=Colors.redAccent})
{
  Get.snackbar(title, message,
  backgroundColor: color,colorText: Colors.white,snackPosition: SnackPosition.TOP);
}