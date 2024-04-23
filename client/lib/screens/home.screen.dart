import 'package:app_flutter/components/bottom_nav_bar.dart';
import 'package:app_flutter/const.dart';
import 'package:flutter/material.dart';

import 'package:app_flutter/screens/screens.dart';

import 'package:app_flutter/services/dish.service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<dynamic> dishesData = [];

  @override
  Widget build(BuildContext context) {

    PageController _pageController = PageController(); //PageController permite controlar la pagina que esta en pageView()
    
    //Navigate bottom bar
    int _paginaActual = 0;

    void navigateBottomBar(int index){
      this.setState(() {
        _paginaActual = index;
        print(_paginaActual);
      });
    }

    //pages
    final List<Widget> _pages = [
      DishesScreen(dishesData),
      CartScreen(),
      //Container(child: Text("Food"), alignment: Alignment.center)
    ];
    
    // UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu cafetería'),
      ),
      backgroundColor: backgroundColor,
      body: PageView(
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: MyBottomBar(
        onTapChangeIndex: (index) {
          setState(() {
            _paginaActual = index;
            print(_paginaActual);
            _pageController.animateToPage(_paginaActual, duration: Duration(milliseconds: 100), curve: Curves.easeIn); //Permite la transicion
          });
          }),
    );
  }

  CallDishes() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      var res = await DishService().getDishes(token!).then((res) {
        if (res == null) {
          print("No hay dishes");
        } else {
          setState(() {
            dishesData = List.from(
                res); //Para copiar la data de una List a otra se usa List.from();
          });
          print(dishesData);
          print("hola xd");
        }
      });
    }

  //initState se ejecuta antes del build
  @override
  void initState() {
    CallDishes();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    CallDishes();
    super.didUpdateWidget(oldWidget);
  }


}