import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/services/firebase_auth_services.dart';
import 'package:mov_id/ui/widgets/buble_background.dart';
import 'package:mov_id/ui/widgets/error_message.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  var _isSecure = true;

  var _email = '';
  var _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ConstantVariable.deviceHeight(context),
        width: ConstantVariable.deviceWidth(context),
        child: Stack(
          children: [
            bubleBackground(context),
            _content(context),
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              //Image And Title
              Image(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              ),
              SizedBox(height: 20),
              Text(
                'Hallo And Welcome! \nMoviews',
                style: ConstantVariable.textFont.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //Space
              SizedBox(height: 250),
              //InputField and Button
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Email Input Field
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      cursorColor: Colors.purple,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your email address.';
                        }
                        //if validated
                        return null;
                      },
                      onSaved: (value) {
                        _email = value.trim();
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(MdiIcons.emailOutline),
                        labelText: 'E-mail',
                        hintText: 'max@gmail.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    //Space
                    SizedBox(height: 10),
                    //PAssword Input Field
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      obscureText: _isSecure,
                      maxLines: 1,
                      cursorColor: Colors.purple,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your password.';
                        }
                        //if validated
                        return null;
                      },
                      onSaved: (value) {
                        _password = value.trim();
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(MdiIcons.lockOutline),
                        labelText: 'Password',
                        hintText: '*********',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: _isSecure
                              ? Icon(MdiIcons.eyeOffOutline)
                              : Icon(MdiIcons.eyeOutline),
                          onPressed: () {
                            //change value of secure text
                            setState(() {
                              _isSecure = !_isSecure;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              //Check if button clicked or not
              _isLoading
                  //Loading while try to login
                  //only show if login button clicked
                  ? Container(
                      height: 50,
                      child: SpinKitThreeBounce(
                        color: ConstantVariable.primaryColor,
                        size: 15,
                      ),
                    )
                  //Button Login
                  : Container(
                      height: 50,
                      width: ConstantVariable.deviceWidth(context),
                      child: OutlineButton(
                        //Colors outline in state not Clicked
                        borderSide: BorderSide(
                          color: ConstantVariable.primaryColor,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: _login,
                        child: Text(
                          'Login',
                          style: ConstantVariable.textFont.copyWith(
                            color: ConstantVariable.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 15),
              //Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot your password ? ',
                    style: ConstantVariable.textFont,
                  ),
                  GestureDetector(
                    onTap: _forgotPassword,
                    child: Text(
                      'Get it now !',
                      style: ConstantVariable.textFont.copyWith(
                        color: ConstantVariable.primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              Align(
                  alignment: Alignment.center,
                  child: Text('-Don\'t have an account ?-')),
              SizedBox(height: 15),
              //Button Register
              Container(
                height: 50,
                width: ConstantVariable.deviceWidth(context),
                child: RaisedButton(
                  elevation: 0,
                  color: ConstantVariable.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: _register,
                  child: Text(
                    'Register',
                    style: ConstantVariable.textFont.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              //space to avoid bottom
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  //Methode
  void _login() async {
    //get state from form with formkey
    var _formState = _formKey.currentState;
    //show Loading indicator
    setState(() {
      _isLoading = !_isLoading;
    });
    //save user input into variable
    _formState.save();
    //check validation textformfield
    if (_formState.validate()) {
      //try to login
      var _result =
          await FirebaseAuthServices.login(email: _email, password: _password);
      //check login status and show message if error occured
      if (_result.errorMessage != null) {
        //
        errorMessage(message: _result.errorMessage, context: context);
      } else {
        //
        Navigator.pushReplacementNamed(context, '/wrapper');
      }
    }
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _register() {
    //go to Register Page
    Navigator.pushNamed(context, '/register_page');
  }

  void _forgotPassword() {
    // coming Soon
    errorMessage(message: 'Coming Soon :D ', context: context);
  }
}
