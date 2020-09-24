import 'package:flutter/material.dart';
import 'package:mov_id/ui/pages/login_page.dart';
import 'package:mov_id/ui/pages/register_confirmation_page.dart';
import 'package:mov_id/ui/pages/register_page.dart';
import 'package:mov_id/ui/pages/register_preference_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie ID',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      routes: {
        '/register_page': (context) => RegisterPage(),
        '/register_preference_page': (context) => RegisterPreferencePage(),
        '/register_confirmation_page': (context) => RegisterConfirmationPage(),
      },
    );
  }
}
