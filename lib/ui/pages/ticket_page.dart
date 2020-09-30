import 'package:flutter/material.dart';
import 'package:mov_id/core/services/firebase_auth_services.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
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
