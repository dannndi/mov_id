import 'package:flutter/material.dart';
import 'package:mov_id/core/services/firebase_auth_services.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
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
