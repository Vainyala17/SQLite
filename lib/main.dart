
// ** for example 1 and 2**
// Import example 1
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_learning/example1/user_list.dart';
import 'example1/user.dart';

// Import example 2
import 'example2/database.dart';
import 'example2/homePage.dart';

void main() async {
  // Initialize the database and insert users
  WidgetsFlutterBinding.ensureInitialized();
  // await Database.instance.initDb();
  // await Database.instance.initializeUsers();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Management',
//       home: UserList(), // exmaple1
      home: Home(), // example2
    );
  }
}





