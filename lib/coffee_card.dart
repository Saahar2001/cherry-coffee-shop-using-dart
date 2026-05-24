import 'package:flutter/material.dart';
import 'coffee.dart';
//slide used 162
class CoffeeCard extends StatelessWidget {
  final Coffee coffee;
  final Function(Coffee, int) updateQuantity;

  const CoffeeCard({
    required this.coffee,
    required this.updateQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(coffee.image, height: 80, fit: BoxFit.cover),
          Text(
            coffee.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('${coffee.price} SR', style: TextStyle(color: Colors.red)),
          Text('Quantity: ${coffee.quantity}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => updateQuantity(coffee, -1),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => updateQuantity(coffee, 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
