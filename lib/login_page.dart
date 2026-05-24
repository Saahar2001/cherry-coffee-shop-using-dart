import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'register_page.dart';
import 'database_service.dart';

//slide used 93,94,95,98, 114, 129, 130, 131,132, and 133
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Controller Variable To read the textbox input value
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadname();
  }

  void loadname() async {
    //slide 129,130,131,132,133

    final prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString('name');

    if (name != null && name != '') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  void savename() async {
    if (username.text.isEmpty || password.text.isEmpty) {
      print('Please enter username and password');
    } else {
      bool result = await DatabaseService.loginUser(
        username.text,
        password.text,
      );

      if (result == true) {
        final prefs = await SharedPreferences.getInstance();

        prefs.setString('name', username.text);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        print('Invalid username or password');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cherry Coffee Login'),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 430,
              height: 155,
              child: Image.asset('images/banner.png', fit: BoxFit.cover),
            ),

            SizedBox(height: 25),

            Text(
              'Cherry Coffee',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 35),

            Container(
              width: 300,
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'user name',
                  icon: Icon(Icons.verified_user_rounded),
                ),
              ),
            ),

            SizedBox(height: 25),

            Container(
              width: 300,
              child: TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                  icon: Icon(Icons.lock),
                ),
              ),
            ),

            SizedBox(height: 35),

            TextButton(
              child: Text('login'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.brown,
                side: BorderSide(color: Colors.brown, width: 1),
                elevation: 20,
              ),
              onPressed: savename,
            ),

            SizedBox(height: 30),

            TextButton(
              child: Text('Create new account'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
