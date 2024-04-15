import 'package:app_flutter/screens/screens.dart';
import 'package:app_flutter/services/dish.service.dart';
import 'package:flutter/material.dart';

import 'package:app_flutter/services/order.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeSellerScreen extends StatefulWidget {
  const HomeSellerScreen({super.key});

  @override
  State<HomeSellerScreen> createState() => _HomeSellerScreenState();
}

class _HomeSellerScreenState extends State<HomeSellerScreen> {
  List<dynamic> ordersData = [];
  List<dynamic> dishesData = [];

  CallOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    var res = await orderService().getOrders(token!).then((res) {
      if (res == null) {
        print("No hay orders");
      } else {
        setState(() {
          ordersData = List.from(res);
        });
        print(ordersData);
        print(ordersData.length);
      }
    });
  }

  CallDishes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    var res = await DishService().getDishes(token!).then((res) {
      if (res == null) {
        print("No hay dishes");
      } else {
        setState(() {
          dishesData = List.from(res);
        });
      }
    });
  }

  //initState se ejecuta antes del build
  @override
  void initState() {
    CallOrders();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomeSellerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    int paginaActual = 0;
    PageController pageController =
        PageController(); //PageController permite controlar la pagina que esta en pageView()

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu cafetería'),
      ),
      body: PageView(
        controller: pageController,
        children: [
          DishesScreen(dishesData),
          OrdersScreen(ordersData),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaActual, //Es el index del array 'items'
        items: const [
          //Este array solo pide widgets de tipo BottomNavigationBarItem
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: 'Food'),
        ],
        selectedItemColor: Colors.blue,
        onTap: (index) {
          //Se ejecuta al darle tap a un item y devuelve un valor int a esta funcion, el index

          setState(() {
            paginaActual = index;
          });
          //_pageController.jumpToPage(_paginaActual);
          pageController.animateToPage(paginaActual,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn);
        },
      ),
    );
  }
}
