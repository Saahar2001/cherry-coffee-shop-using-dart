import 'package:mysql_client/mysql_client.dart';
import 'coffee.dart';

//slide used 166 and 167
class DatabaseService {
  static Future<void> saveUser(
    String username,
    String email,
    String password,
  ) async {
    try {
      print("Attempting to save user...");

      // Step 1: Establish the connection
      final conn = await MySQLConnection.createConnection(
        host: "mysql5045.site4now.net",
        port: 3306,
        userName: "ac7ea4_bds",
        password: "PUT_YOUR_PASSWORD_HERE",
        databaseName: "db_ac7ea4_bds",
      );

      await conn.connect();
      print("Connected to MySQL.");

      // Step 2: Insert into users table
      var result = await conn.execute(
        "INSERT INTO users (username, email, password) VALUES (:username, :email, :password)",
        {"username": username, "email": email, "password": password},
      );

      int id = result.lastInsertID.toInt();
      print("User ID: $id inserted successfully.");

      await conn.close();
    } catch (e) {
      print("Database error: $e");
    }
  }

  //slide 155 get books example
  static Future<bool> loginUser(String username, String password) async {
    try {
      print("Attempting to login...");

      final conn = await MySQLConnection.createConnection(
        host: "mysql5045.site4now.net",
        port: 3306,
        userName: "ac7ea4_bds",
        password: "PUT_YOUR_PASSWORD_HERE",
        databaseName: "db_ac7ea4_bds",
      );

      await conn.connect();
      print("Connected to MySQL.");

      var result = await conn.execute(
        "SELECT * FROM users WHERE username = :username AND password = :password",
        {"username": username, "password": password},
      );

      await conn.close();

      if (result.rows.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Database error: $e");
      return false;
    }
  }

  static Future<void> saveOrder(String custname, List<Coffee> coffees) async {
    try {
      print("Attempting to place an order...");

      // Step 1: Establish the connection
      final conn = await MySQLConnection.createConnection(
        host: "mysql5045.site4now.net",
        port: 3306,
        userName: "ac7ea4_bds",
        password: "PUT_YOUR_PASSWORD_HERE",
        databaseName: "db_ac7ea4_bds",
      );

      await conn.connect();
      print("Connected to MySQL.");

      // Step 2: Insert into orders table
      final total = coffees.fold(0, (sum, c) => sum + c.price * c.quantity);

      var result = await conn.execute(
        "INSERT INTO orders (custname, total) VALUES (:custname, :total)",
        {"custname": custname, "total": total},
      );

      int id = result.lastInsertID.toInt();
      print("Order ID: $id inserted successfully.");

      // Step 3: Insert coffees into purchases table
      for (var coffee in coffees.where((c) => c.quantity > 0)) {
        await conn.execute(
          "INSERT INTO purchases (name, price, quantity) VALUES (:name, :price, :quantity)",
          {
            "name": coffee.name,
            "price": coffee.price,
            "quantity": coffee.quantity,
          },
        );
      }

      print("Order placed successfully!");
      await conn.close();
    } catch (e) {
      print("Database error: $e");
    }
  }
}
