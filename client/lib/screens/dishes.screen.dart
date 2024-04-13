import 'package:flutter/material.dart';

class DishesScreen extends StatefulWidget {

  final List dishesData;

  const DishesScreen(this.dishesData, {super.key});

  @override
  State<DishesScreen> createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: ListView.builder(
        itemCount: widget.dishesData.length,
        itemBuilder: (context, index) {

          return Card(
            child: Row(
              children: [
                Text("${widget.dishesData[index]['name']}"),
                SizedBox(width: 10.0,),
                Text("Precio: ${widget.dishesData[index]['price']}")
              ],
            ),
          );
        },)
        );
  }
}