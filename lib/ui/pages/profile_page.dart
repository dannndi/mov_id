import 'package:flutter/material.dart';
import 'package:mov_id/core/providers/user_provider.dart';
import 'package:mov_id/core/services/firebase_auth_services.dart';
import 'package:provider/provider.dart';

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
          child: Column(
            children: [
              // Consumer<UserProvider>(
              //   builder: (context, userProvider, _) => Container(
              //     height: 300,
              //     width: 300,
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       image: DecorationImage(
              //         image: NetworkImage(userProvider.userApp.profilePicture),
              //       ),
              //     ),
              //   ),
              // ),
              RaisedButton(
                child: Text('Logout'),
                onPressed: () {
                  FirebaseAuthServices.logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login_page', (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
