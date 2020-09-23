import 'package:flutter/material.dart';
import 'package:mov_id/core/base/shared_variable.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            _background(context),
            _content(context),
          ],
        ),
      ),
    );
  }

  _background(BuildContext context) {
    return Container();
  }

  _content(BuildContext context) {
    return Container();
  }
}
