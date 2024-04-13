import 'package:flutter/material.dart';

import 'package:app_flutter/screens/screens.dart';

import 'package:app_flutter/services/dish.service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<dynamic> dishesData = [];

  CallDishes() async {
    
    var res = await DishService().getDishes("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYTRjYzg4MWVhZWU0ZDg3YzgyMGFmZiIsImlhdCI6MTY3MzAyOTA1NCwiZXhwIjoxNjczMTE1NDU0fQ.92MJfrsI5F6zqthOkIfmfkwhmFabl54LGN_GizkdONY").then((res) {
      
      if(res == null){
        print("No hay dishes");
      }
      else
      {
        setState(() {
          
          dishesData = List.from(res); //Para copiar la data de una List a otra se usa List.from();
        });
        print(dishesData);
        print(dishesData.length);
      }
    });
  }

  //initState se ejecuta antes del build
  @override
  void initState() {

    super.initState();
    CallDishes();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    
    CallDishes();
    super.didUpdateWidget(oldWidget);
  }
  
  @override
  Widget build(BuildContext context) {

    int _paginaActual = 0;
    PageController _pageController = PageController(); //PageController permite controlar la pagina que esta en pageView()

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu cafetería'),
      ),
      body: PageView(
        controller: _pageController,
        children: [ //Aqui agregamos las paginas
          DishesScreen(dishesData),
          Container(child: Text("Food"), alignment: Alignment.center),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaActual, //Es el index del array 'items'
        items: [ //Este array solo pide widgets de tipo BottomNavigationBarItem
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: 'Food'),
        ],
        selectedItemColor: Colors.blue,
        onTap: (index) {//Se ejecuta al darle tap a un item y devuelve un valor int a esta funcion, el index
          
          setState(() {
            _paginaActual = index;
          });
          //_pageController.jumpToPage(_paginaActual);
          _pageController.animateToPage(_paginaActual, duration: Duration(milliseconds: 100), curve: Curves.easeIn);
          
        },
      ),
    );
  }
}