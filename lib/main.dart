import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mov_id/core/providers/movie_provider.dart';
import 'package:mov_id/core/providers/user_provider.dart';
import 'package:mov_id/core/services/firebase_auth_services.dart';
import 'package:mov_id/ui/pages/login_page.dart';
import 'package:mov_id/ui/pages/main_page.dart';
import 'package:mov_id/ui/pages/register_confirmation_page.dart';
import 'package:mov_id/ui/pages/register_page.dart';
import 'package:mov_id/ui/pages/register_preference_page.dart';
import 'package:mov_id/ui/pages/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: FirebaseAuthServices.userStream),
        ChangeNotifierProvider(create: (context) => MovieProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie ID',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
        routes: {
          '/wrapper': (context) => Wrapper(),
          '/login_page': (context) => LoginPage(),
          '/register_page': (context) => RegisterPage(),
          '/register_preference_page': (context) => RegisterPreferencePage(),
          '/register_confirmation_page': (context) =>
              RegisterConfirmationPage(),
          '/main_page': (context) => MainPage(),
        },
      ),
    );
  }
}
