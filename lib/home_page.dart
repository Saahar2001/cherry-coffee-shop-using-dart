import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'coffee_shop.dart';
import 'login_page.dart';

//slide used 55,108 114,
class HomePage extends StatelessWidget {
  void logout(BuildContext context) async {
    //slide 129,130,131,132,133
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('name', '');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cherry Coffee Home'),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/banner.png', height: 150),

            SizedBox(height: 20),

            Text(
              'Welcome to Cherry Coffee',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              child: Text('View Coffee Shop menu'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CoffeeShop()),
                );
              },
            ),

            SizedBox(height: 20),

            ElevatedButton(
              //slide 119
              child: Text('Logout'),
              onPressed: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
