import 'package:flutter/material.dart';
import 'package:mov_id/core/models/register_user.dart';

class RegisterConfirmationPage extends StatelessWidget {
  RegisterUser _registerUser;

  @override
  Widget build(BuildContext context) {
    _registerUser = ModalRoute.of(context).settings.arguments;

    print(_registerUser.name);
    print(_registerUser.selectedLanguage);
    return Scaffold(
      body: Container(),
    );
  }
}
