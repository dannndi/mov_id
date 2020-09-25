import 'package:flutter/material.dart';
import 'package:mov_id/core/services/firebase_auth_services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('Logout'),
            onPressed: () {
              FirebaseAuthServices.logout();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login_page', (route) => false);
            },
          ),
        ),
      ),
    );
  }
}
