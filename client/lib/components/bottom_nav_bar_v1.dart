import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  
  PageController _pageController = PageController(); //PageController permite controlar la pagina que esta en pageView()
  int _paginaActual = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: _paginaActual,
        onTap: (index) {//Se ejecuta al darle tap a un item y devuelve un valor int a esta funcion, el index

          setState(() {
            _paginaActual = index;
          });
          //_pageController.jumpToPage(_paginaActual);
          _pageController.animateToPage(_paginaActual, duration: Duration(milliseconds: 100), curve: Curves.easeIn);

        },
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Shop", icon: Icon(Icons.shopping_bag_outlined)),
        ],
      );
  }
}