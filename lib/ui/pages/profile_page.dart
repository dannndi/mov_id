import 'package:flutter/material.dart';
import 'package:mov_id/core/services/firebase_auth_services.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
