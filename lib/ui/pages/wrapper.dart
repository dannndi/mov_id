import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/providers/movie_provider.dart';
import 'package:mov_id/core/providers/ticket_provider.dart';
import 'package:mov_id/core/providers/transaction_provider.dart';
import 'package:mov_id/core/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  User _user;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      if (_user == null) {
        Navigator.pushReplacementNamed(context, '/login_page');
      } else {
        //* clear user if in case theis's still user in userProvider
        Provider.of<UserProvider>(context, listen: false).clearUser();
        Provider.of<MovieProvider>(context, listen: false).clearMovie();
        Provider.of<TicketProvider>(context, listen: false).clearTicket();
        Provider.of<TransactionProvider>(context, listen: false)
            .clearTransaction();

        //*
        Navigator.pushReplacementNamed(context, '/main_page');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User>(context);
    return Scaffold(
      body: Container(),
    );
  }
}
