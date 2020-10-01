import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/models/register_user.dart';
import 'package:mov_id/core/services/firebase_auth_services.dart';
import 'package:mov_id/ui/widgets/buble_background.dart';
import 'package:mov_id/ui/widgets/error_message.dart';

class RegisterConfirmationPage extends StatefulWidget {
  @override
  _RegisterConfirmationPageState createState() =>
      _RegisterConfirmationPageState();
}

class _RegisterConfirmationPageState extends State<RegisterConfirmationPage> {
  RegisterUser _registerUser;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    //geting data from argument in previous page
    _registerUser = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Confirm your data',
          style: ConstantVariable.textFont.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          bubleBackground(context),
          _content(context),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        width: ConstantVariable.deviceWidth(context),
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: _isLoading
            ? SpinKitThreeBounce(
                color: ConstantVariable.accentColor2,
                size: 15,
              )
            : RaisedButton(
                elevation: 0,
                color: ConstantVariable.accentColor2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  _confirmRegistration(context);
                },
                child: Text(
                  'Confirm Registration',
                  style: ConstantVariable.textFont.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: 450,
          margin: EdgeInsets.fromLTRB(44, 60, 44, 0),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 24,
                spreadRadius: 0.1,
                offset: Offset(0, 0),
              ),
            ],
            color: Color(0xFFf6f6f6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Your Account Data ',
                style: ConstantVariable.textFont.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(height: 2),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: (_registerUser.profilePicture == null)
                        ? AssetImage('assets/images/user_pic.png')
                        : FileImage(_registerUser.profilePicture),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nama', style: ConstantVariable.textFont),
                  Text(
                    _registerUser.name,
                    style: ConstantVariable.textFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('E-mail', style: ConstantVariable.textFont),
                  Text(
                    _registerUser.email,
                    style: ConstantVariable.textFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Languange', style: ConstantVariable.textFont),
                  Text(
                    _registerUser.language,
                    style: ConstantVariable.textFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Prefered Genre', style: ConstantVariable.textFont),
                  Text(
                    '${_registerUser.preferedGenres.join('\n')}',
                    style: ConstantVariable.textFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmRegistration(BuildContext context) async {
    //change button to progres indicator
    setState(() {
      _isLoading = !_isLoading;
    });

    var _result = await FirebaseAuthServices.registerNewUser(
      email: _registerUser.email,
      password: _registerUser.password,
      name: _registerUser.name,
      language: _registerUser.language,
      preferenGenre: _registerUser.preferedGenres,
    );

    //change progres indicator to button back
    setState(() {
      _isLoading = !_isLoading;
    });

    //check if register success or not
    if (_result.errorMessage != null) {
      errorMessage(message: _result.errorMessage, context: context);
    } else {
      //alert user that register is success
      Flushbar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        message: 'Register success, Loging in......',
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
      //
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/wrapper',
          (route) => false,
        );
      });
    }
  }
}
