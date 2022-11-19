import 'package:flutter/material.dart';
import 'package:news_app/screens/home_screen.dart';

import 'screens/category_news.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      home: HomeScreen(),
    );
  }
}
