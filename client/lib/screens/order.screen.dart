import 'package:app_flutter/models/coffee.dart';
import 'package:app_flutter/screens/cart.screen.dart';
import 'package:app_flutter/screens/home.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:app_flutter/models/coffee.dart';
import 'package:app_flutter/models/coffee_shop.dart';

class OrderScreen extends StatefulWidget {

  final Coffee coffee;
  const OrderScreen({super.key, required this.coffee});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  double sweetValue = 0.5;
  double iceValue = 0.5;

  void customSweet(double newValue){
    setState(() {
      sweetValue = newValue;
    });
  }

  void customIce(double newValue){
    setState(() {
      iceValue = newValue;
    });
  }

  void addToCart(Coffee coffee) {
    //add to card
    Provider.of<CoffeeShop>(context, listen: false).addItemToCard(coffee);

    //go back to shop page
    Navigator.pop(context);

    //let use know it has been successfuly added
    showDialog(context: context, builder: 
      (context) => AlertDialog(title: const Text('Se ha añadido a tu carrito')
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.coffee.name),
        ),
        backgroundColor: Colors.brown,
        body: Column(
          children: 
          [
            Center(
              child: Container(
                child: Image.asset(widget.coffee.imagePath),
                width: MediaQuery.of(context).size.width / 1.5,
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
              ),
            ),
      
            // Options
            Column(children: 
            [
              //Sugar
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 65, 25, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text("Cucharadas de azúcar", style: TextStyle(color: Colors.white),)
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: const SliderThemeData(
                          thumbColor: Color.fromARGB(255, 235, 97, 47),
                          overlayColor: Color.fromARGB(255, 235, 213, 47),
                          activeTrackColor: Color.fromARGB(255, 235, 213, 47),
                          ),
                        child: Slider(
                          value: sweetValue,
                          label: (sweetValue*2).toString(),
                          divisions: 2,
                          onChanged: ((value) => customSweet(value))
                        ),
                      )
                    )
                  ],
                ),
              ),
      
              //Ice
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 35, 25, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text("Hielo", style: TextStyle(color: Colors.white),)
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: const SliderThemeData(
                          thumbColor: Color.fromARGB(255, 235, 97, 47),
                          overlayColor: Color.fromARGB(255, 235, 213, 47),
                          activeTrackColor: Color.fromARGB(255, 235, 213, 47),
                          ),
                        child: Slider(
                          value: iceValue,
                          label: (iceValue*2).toString(),
                          divisions: 2,
                          onChanged: ((value) => customIce(value))
                        ),
                      )
                    )
                  ],
                ),
              ),

              //Button
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: MaterialButton(
                  padding: EdgeInsets.all(25.0),
                  child: Text('Añade al tu carrito',
                  style: TextStyle(color: Colors.white),
                  ),
                  color: Color.fromRGBO(129, 17, 17, 1),
                  onPressed: () => addToCart(widget.coffee),
                ),
              )
      
            ],)
          ],
        ),
      ),
    );
  }
}