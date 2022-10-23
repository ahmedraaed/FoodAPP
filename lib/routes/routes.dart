import 'package:foodapp/screen/auth/sign_in_screen.dart';
import 'package:foodapp/screen/cart/cart_page.dart';
import 'package:foodapp/screen/home_page/home_page.dart';
import 'package:foodapp/screen/location_screen.dart';
import 'package:foodapp/screen/pick_address_map.dart';
import 'package:foodapp/screen/popular_food_details.dart';
import 'package:foodapp/screen/splash/splash_sceen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screen/recomended_food_detailes.dart';

class RoutesHelper
{
  static const String splashScreen='/splash';
  static const String initial='/';
  static const String popularFood='/popluarfood';
  static const String recommendedFood='/recommendedfood';
  static const String cartFood='/cartfood';
  static const String signIn='/signin';
  static const String addAdress='/addAddress';
  static const String pickAdddress='/pickAddress';

  static String getSpalshScreen='$splashScreen';
  static String getHomeFood()=>'$initial';
  static String getPopluarFood(int pageId,String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId,String page)=>'$recommendedFood?pageId=$pageId&&page=$page';
  static String getCartFood()=>'$cartFood';
  static String getSignIn()=>'$signIn';
  static String getAddAddress()=>'$addAdress';
  static String getPickAddress()=>'$pickAdddress';


  static List<GetPage> routes=[

    GetPage(name: pickAdddress, page: ()
    {
      PickAddressMap pickAddressMap=Get.arguments;
      return pickAddressMap;
    }),
    GetPage(name: getSpalshScreen, page: ()=>SplashScreen()),
    GetPage(name: signIn, page:()=>SignInScreen()),
    GetPage(name: initial, page: ()=>HomePage(),transition: Transition.leftToRight),
    GetPage(name:popularFood , page: () {

     var pageid=Get.parameters['pageId'];
     var page=Get.parameters['page'];
      return PopularFoodDetails(PageId: int.parse(pageid!),page:page!);

    }, transition: Transition.zoom),
    GetPage(name:recommendedFood , page: () {
      var pageId=Get.parameters['pageId'];
      var page=Get.parameters['page'];
      return RecomendedFoodDetailes(pageId:int.parse(pageId!),page:page!);
    },transition: Transition.zoom),
    
    GetPage(name: cartFood, page:() {
      return CartPage();
    }),
    GetPage(name: addAdress, page:() {
      return LocationScreen();
    }),
  ];
}