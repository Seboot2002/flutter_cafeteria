import 'package:app_flutter/screens/order.screen.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/screens/screens.dart';
import 'package:provider/provider.dart';//Aqui importamos todos los screens para ahorrar espacio
import 'models/coffee_shop.dart';

void main() {
  runApp(const MyApp());
}

//StatelessWidget dibuja una vez y no nos permite cambiar los valores mostrados
class MyApp extends StatelessWidget {
  const MyApp({super.key});//Constructor, pero si se agrega el {} se vuelven opcionales los parametros

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => CoffeeShop()),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: HomeScreen(), /*const MyHomePage(title: 'Flutter Demo Home Page')*/
        routes: {
          '/home': (context) => HomeScreen(),
          '/shop': (context) => ShopScreen(),
          '/cart': (context) => CartScreen(),
        },
      )
    );
  }
}