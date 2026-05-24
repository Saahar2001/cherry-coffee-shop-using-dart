import 'package:flutter/material.dart';
import 'coffee.dart';
import 'coffee_card.dart';
import 'buy_page.dart';

// slide used 163 and 164 and 165
class CoffeeShop extends StatefulWidget {
  @override
  _CoffeeShopState createState() => _CoffeeShopState();
}

class _CoffeeShopState extends State<CoffeeShop> {
  final List<Coffee> _coffees = [
    Coffee('Cherry Latte', 18, 'images/cherry_latte.png'),
    Coffee('Iced Americano', 14, 'images/iced_americano.png'),
    Coffee('Spanish Latte', 19, 'images/spanish_latte.png'),
    Coffee('Caramel Frappuccino', 22, 'images/caramel_frappuccino.png'),
    Coffee('Mocha', 20, 'images/mocha.png'),
    Coffee('Espresso', 12, 'images/espresso.png'),
    Coffee('Croissant', 10, 'images/croissant.png'),
    Coffee('Cheesecake', 16, 'images/cheesecake.png'),
  ];

  void _updateQuantity(Coffee coffee, int change) {
    setState(() {
      coffee.quantity = (coffee.quantity + change).clamp(0, 99);
    });
  }

  void goToBuyPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BuyPage(_coffees)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cherry Coffee Shop'),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          Image.asset('images/banner.png'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Cherry Coffee Shop',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: _coffees.length,
              itemBuilder: (context, index) {
                return CoffeeCard(
                  coffee: _coffees[index],
                  updateQuantity: _updateQuantity,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: goToBuyPage,
              child: Text('Go to Buy Page'),
            ),
          ),
        ],
      ),
    );
  }
}
