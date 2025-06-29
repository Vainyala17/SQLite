
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



// ** For example 3 **
//
// import 'package:flutter/material.dart';
//
// import 'example3/db/database_helper.dart';
// import 'example3/screens/fetch_data_screen.dart';
// import 'example3/widgets/custom_drawer.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await DatabaseHelper.instance.database; // ✅ Correctly initializes DB
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Personal Details App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.grey[50],
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.blue[600],
//           foregroundColor: Colors.white,
//           elevation: 4,
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blue[600],
//             foregroundColor: Colors.white,
//             padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide(color: Colors.grey[300]!),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
//           ),
//           contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         ),
//       ),
//       home: HomePage(),
//       routes: {
//         '/fetchData': (context) => FetchDataScreen(), // ✅ Correct place
//       },
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Personal Details App'),
//         centerTitle: true,
//       ),
//
//       drawer: CustomDrawer(),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.blue[50]!, Colors.white],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.person_outline,
//                 size: 80,
//                 color: Colors.blue[600],
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Welcome',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey[800],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 10),
//               Text(
//                 'Use the drawer menu to navigate',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
