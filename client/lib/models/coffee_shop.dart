import 'package:app_flutter/models/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeShop extends ChangeNotifier{
  final List<Coffee> _shop = [
    Coffee(
        name: 'Long Black',
        price: "4.10",
        imagePath: 'lib/assets/images/black.png'
    ),
        
    Coffee(
      name: 'Latte', 
      price: "4.20", 
      imagePath: 'lib/assets/images/tea.png'
      ),
    Coffee(
        name: 'Espresso', 
        price: "4.00", 
         imagePath: 'lib/assets/images/espresso.png'
         ),
    Coffee(
        name: 'Cappuccino',
        price: '4.50',
        imagePath: 'lib/assets/images/iced_coffee.png'
        ),
  ];
  //coffee for sale
  List<Coffee> _userCard = [];

  //user card:

  //get coffee list
  List<Coffee> get coffeeShop => _shop;

  //get user card
  List<Coffee> get userCard => _userCard;
  //add item to card
  void addItemToCard(Coffee coffee){
    _userCard.add(coffee);
    notifyListeners(); //Notificamos que se produjo un cambio al Listener
  }
  //remove item to card
  void removeItemFromCard(Coffee coffee){
    _userCard.remove(coffee);
    notifyListeners();
  }
}