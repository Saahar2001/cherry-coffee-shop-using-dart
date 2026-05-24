import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'database_service.dart';
import 'login_page.dart';

//slide used 93,94,95,98, 114, 129, 130, 131,132, and 133
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool agree = false;

  void saveRegister() async {
    //slide 11 and 114
    if (username.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty ||
        confirmPassword.text.isEmpty) {
      print('Please fill all fields');
    } else if (password.text != confirmPassword.text) {
      print('Passwords do not match');
    } else if (agree == false) {
      print('Please accept terms');
    } else {
      final prefs = await SharedPreferences.getInstance();
      await DatabaseService.saveUser(username.text, email.text, password.text);
      prefs.setString('name', username.text);
      prefs.setString('email', email.text);
      prefs.setString('password', password.text);
      // slide 114
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cherry Coffee Register'),
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

            SizedBox(height: 22),

            Text(
              'Create Account',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 25),

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

            SizedBox(height: 18),

            Container(
              width: 300,
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'email',
                  icon: Icon(Icons.email),
                ),
              ),
            ),

            SizedBox(height: 18),

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

            SizedBox(height: 18),

            Container(
              width: 300,
              child: TextField(
                controller: confirmPassword,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'confirm password',
                  icon: Icon(Icons.lock),
                ),
              ),
            ),

            SizedBox(height: 15),

            Container(
              width: 300,
              child: Row(
                children: [
                  Checkbox(
                    value: agree,
                    onChanged: (value) {
                      setState(() {
                        if (agree == false) {
                          agree = true;
                        } else {
                          agree = false;
                        }
                      });
                    },
                    activeColor: Colors.brown,
                  ),
                  Text('I agree to the terms'),
                ],
              ),
            ),

            SizedBox(height: 18),

            TextButton(
              child: Text('register'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.brown,
                side: BorderSide(color: Colors.brown, width: 1),
                elevation: 20,
              ),
              onPressed: saveRegister,
            ),

            SizedBox(height: 18),

            TextButton(
              child: Text('Login to existing account'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
