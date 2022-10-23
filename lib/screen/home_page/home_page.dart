import 'package:flutter/material.dart';
import 'package:foodapp/screen/auth/sign_up_screen.dart';
import 'package:foodapp/screen/cart/cart_page.dart';
import 'package:foodapp/screen/home/main_food_page.dart';
import 'package:foodapp/utiles/app_colors.dart';

import '../account/account_screen.dart';
import '../auth/sign_in_screen.dart';
import '../cart/cart_history_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex=0;
  List page=[
    MainFoodPage(),
    Container(child: Text('Archived'),),
    CartHistoryScreen(),
    // CartPage(),
    AccountScreen(),
  ];
  void NbOnTap(int index)
  {

    setState((){
      _pageIndex = index;
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap:NbOnTap ,
         selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.deepOrangeAccent,
        currentIndex: _pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: "Archive",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: "Me",
          ),
        ],
      ),

    );
  }
}
