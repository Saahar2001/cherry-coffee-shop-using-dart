import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'coffee.dart';
import 'database_service.dart';
// slide used 163 and 164 and 165

class BuyPage extends StatelessWidget {
  final List<Coffee> coffees;

  BuyPage(this.coffees);

  Future<void> _buy(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final name = prefs.getString('name') ?? '';

      await DatabaseService.saveOrder(name, coffees);
      print('Order placed successfully');

      final total = coffees.fold(0, (sum, c) => sum + c.price * c.quantity);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Total Price'),
          content: Text('Your total is $total SR'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error placing order: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = coffees.fold(0, (sum, c) => sum + c.price * c.quantity);

    return Scaffold(
      appBar: AppBar(title: Text('Buy Page'), backgroundColor: Colors.brown),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Total Price',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('$total SR', style: TextStyle(fontSize: 22)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _buy(context);
              },
              child: Text('Buy'),
            ),
          ],
        ),
      ),
    );
  }
}
