import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodapp/routes/routes.dart';
import 'package:foodapp/utiles/dimansions.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource()async{
    await Get.find<PopulerProductController>().getPoplerProductListcontrollrt();
    await Get.find<RecommendedProductController>().getRecommendedProductListcontrollrt();
  }

  @override
  void initState()
  {
    _loadResource();
    super.initState();
    controller=AnimationController(vsync: this,duration: Duration(seconds : 2))..forward();
    animation=CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    Timer(Duration(seconds: 3),() => Get.offNamed(RoutesHelper.getHomeFood()),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
        [
          ScaleTransition(scale: animation,
          child: Center(child: Image.asset("assats/image/logo part 1.png",width: Dimensions.widthScreen/1.2,))),
          Center(child: Image.asset("assats/image/logo part 2.png",width: Dimensions.widthScreen/1.8,)),
        ],
      ),
    );
  }
}
