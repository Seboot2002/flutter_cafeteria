import 'package:flutter/material.dart';

import 'package:app_flutter/screens/screens.dart';

import 'package:app_flutter/services/dish.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> dishesData = [];

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

  @override
  Widget build(BuildContext context) {
    int paginaActual = 0;
    PageController pageController =
        PageController(); //PageController permite controlar la pagina que esta en pageView()

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu cafetería - customer'),
      ),
      body: PageView(
        controller: pageController,
        children: [
          //Aqui agregamos las paginas
          DishesScreen(dishesData),
          Container(alignment: Alignment.center, child: const Text("Food")),
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
