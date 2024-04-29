import 'package:flutter/material.dart';

import '../models/coffee.dart';

// ignore: must_be_immutable
class CoffeeTile extends StatelessWidget {
  final Coffee coffee;
  void Function()? onPressed;
  void Function()? onTap;
  final Widget icon;
  CoffeeTile(
      {super.key,
      required this.coffee,
      required this.onPressed,
      required this.icon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: ListTile(
          title: Text(coffee.name),
          subtitle: Text(coffee.price),
          leading: Image.asset(coffee.imagePath),
          trailing: IconButton(
            icon: icon,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
