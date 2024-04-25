import 'package:app_flutter/components/bottom_nav_bar.dart';
import 'package:app_flutter/const.dart';
import 'package:flutter/material.dart';

import 'package:app_flutter/screens/screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final PageController _pageController = PageController(); //PageController permite controlar la pagina que esta en pageView()
    
    //Navigate bottom bar
    int _paginaActual = 0;
    void navigateBottomBar(int index) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _paginaActual = index;
        });
          print(_paginaActual);
          _pageController.animateToPage(index, duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
      });
    }

  //pages
  final List<Widget> _pages = [
    const ShopScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu cafetería'),
      ),
      backgroundColor: backgroundColor,
      bottomNavigationBar: MyBottomBar(
        onTapChangeIndex: (index) => navigateBottomBar(index)
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
      ),
    );
  }

}