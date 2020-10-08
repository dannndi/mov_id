import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mov_id/core/providers/movie_provider.dart';
import 'package:mov_id/core/providers/ticket_provider.dart';
import 'package:mov_id/core/providers/transaction_provider.dart';
import 'package:mov_id/core/providers/user_provider.dart';
import 'package:mov_id/core/services/firebase_auth_services.dart';
import 'package:mov_id/ui/pages/booking_confirmation_page.dart';
import 'package:mov_id/ui/pages/booking_sucess_page.dart';
import 'package:mov_id/ui/pages/login_page.dart';
import 'package:mov_id/ui/pages/main_page.dart';
import 'package:mov_id/ui/pages/movie_detail_page.dart';
import 'package:mov_id/ui/pages/register_confirmation_page.dart';
import 'package:mov_id/ui/pages/register_page.dart';
import 'package:mov_id/ui/pages/register_preference_page.dart';
import 'package:mov_id/ui/pages/select_seat_page.dart';
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
    //Mengunci orientation layar ke potrait (only work for androids???)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: FirebaseAuthServices.userStream),
        ChangeNotifierProvider(create: (context) => MovieProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => TicketProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
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
          '/movie_detail_page': (context) => MovieDetailPage(),
          '/select_seat_page': (context) => SelectSeatPage(),
          '/booking_confirmation_page': (context) => BookingConfirmationPage(),
          '/booking_success_page': (context) => BookingSuccessPage(),
        },
      ),
    );
  }
}
