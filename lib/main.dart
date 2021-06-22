import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './my_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.pinkAccent,
        fontFamily: 'Quicksand',
        textTheme: TextTheme(headline6: TextStyle(fontFamily: 'Pacifico')),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(fontFamily: 'Pacifico', fontSize: 22),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}