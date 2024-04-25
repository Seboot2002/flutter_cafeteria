import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class MyBottomBar extends StatelessWidget {
  void Function(int)? onTapChangeIndex; //Puedo crear funciones del elemento para pasar data de arriba a abajo. Externo a interno.
  MyBottomBar({super.key, required this.onTapChangeIndex,});

  @override
  Widget build(BuildContext context) {
    return GNav(
        onTabChange: (value) => onTapChangeIndex!(value),
        color: Colors.grey[400],
        mainAxisAlignment: MainAxisAlignment.center,
        activeColor: Colors.grey[700],
        tabBackgroundColor: Colors.grey.shade300,
        tabBorderRadius: 24,
        tabActiveBorder: Border.all(color: Colors.white),
        tabs: const [
          GButton(
            icon: Icons.home, 
            text: "Shop"
          ),
          GButton(
            icon: Icons.shopping_bag_outlined,
            text: "Cart"
          )
        ],
      );
  }
}