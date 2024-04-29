import 'package:app_flutter/components/coffee_tile.dart';
import 'package:app_flutter/models/coffee.dart';
import 'package:app_flutter/models/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  void removeFromCart(Coffee coffee){

    Provider.of<CoffeeShop>(context, listen: false,).removeItemFromCard(coffee);

  }

  //Boton para pagar
  void payNow(){

    Provider.of<CoffeeShop>(context, listen: false).removeAllItems();

    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Gracias por su compra!"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) => Material(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                
                //Heading
                const Text(
                  'Tu carrito de bebidas',
                  style: TextStyle(fontSize: 20),
                ),
        
                //List of cart items
                Expanded(
                  child: ListView.builder(
                    itemCount: value.userCard.length,
                    itemBuilder: (context, index) {
                    
                      //get individual coffees
                      Coffee eachCoffee = value.userCard[index];
        
                      //return coffee tile
                      return CoffeeTile(
                      coffee: eachCoffee, 
                      onPressed: () => removeFromCart(eachCoffee), 
                      icon: const Icon(Icons.delete)
                      ); 
                      },
                  )
                ),
        
                GestureDetector(
                  onTap: payNow,
                  child: Container(
                    padding: EdgeInsets.all(25),
                    width: double.infinity,
                    child: Center(
                      child: Text("Pagar el carrito",
                      style: TextStyle(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
        
            ],),
            )
        ),
      ),
    );
  }
}