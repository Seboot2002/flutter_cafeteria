import 'package:app_flutter/screens/screens.dart';
import 'package:flutter/material.dart';

import 'package:app_flutter/services/order.service.dart';

class HomeSellerScreen extends StatefulWidget {
  const HomeSellerScreen({super.key});

  @override
  State<HomeSellerScreen> createState() => _HomeSellerScreenState();
}

class _HomeSellerScreenState extends State<HomeSellerScreen> {

  List<dynamic> ordersData = [];

  CallOrders() async {
    
    var res = await orderService().getOrders("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYTRjZWFhYTM0NzFjODU1ZDkwM2M2MSIsImlhdCI6MTY3MzEzMTI4NywiZXhwIjoxNjczMjE3Njg3fQ.QJx3E36bNvc3_yrD1nlghitiCef46nne18XSckFRGzM").then((res) {
      
      if(res == null){
        print("No hay dishes");
      }
      else
      {
        setState(() {
          
          ordersData = List.from(res);
        });
        print(ordersData);
        print(ordersData.length);
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

    int _paginaActual = 0;
    PageController _pageController = PageController(); //PageController permite controlar la pagina que esta en pageView()

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu cafetería'),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          OrdersScreen(ordersData),
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