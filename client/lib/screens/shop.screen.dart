import 'package:app_flutter/models/coffee.dart';
import 'package:app_flutter/models/coffee_shop.dart';
import 'package:app_flutter/screens/order.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_flutter/components/coffee_tile.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  void addToCart(Coffee coffee) {
    //add to card
    Provider.of<CoffeeShop>(context, listen: false).addItemToCard(coffee);

    //let user know it add been done successfully
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Añadido a su carrito!"),
      ),
    );
  }

  void goToOrderPage(Coffee coffee){
    //navigate to order page
    Navigator.push(context, 
    MaterialPageRoute(
      builder: ((context) => OrderScreen(coffee: coffee))
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              // Header
              const Text(
                "Cómo quieres tu cafe?",
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 25,),
              
              //List of coffee to buy
              Expanded(
                child: ListView.builder(
                  itemCount: value.coffeeShop.length,
                  itemBuilder: (context, index) {
                    //get individual coffee
                    Coffee eachCoffee = value.coffeeShop[index];
                    
                    //return the title of the coffee
                    return CoffeeTile(
                      coffee: eachCoffee,
                      icon: const Icon(Icons.add),
                      onPressed: () => addToCart(eachCoffee),
                      onTap: () => goToOrderPage(eachCoffee)
                      );

                  }
                )
              )
            ],
          ),
        ),
      )
    );
  }
}