import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/services/firebase_auth_services.dart';
import 'package:mov_id/ui/pages/register_page.dart';
import 'package:mov_id/ui/widgets/buble_background.dart';
import 'package:mov_id/ui/widgets/error_message.dart';
import 'package:mov_id/ui/widgets/toogle_text.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  var _isSecureOnLogin = true;
  var _isSecureOnRegister = true;
  var _state = 'login';

  var _email = '';
  var _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: ConstantVariable.deviceHeight(context),
          width: ConstantVariable.deviceWidth(context),
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _title(context),
                _content(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    if (_state == 'login') {
      return Container(
        height: ConstantVariable.deviceHeight(context) * 0.15,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: ConstantVariable.textFont.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Hallo, welcome back Moviewers. \nplease login with with your account',
              style: ConstantVariable.textFont.copyWith(
                fontSize: 16,
                color: ConstantVariable.accentColor3,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: ConstantVariable.deviceHeight(context) * 0.07,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Register',
              style: ConstantVariable.textFont.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _content(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              ToogleText(
                text: 'Login',
                isSelected: _state == 'login',
                space: 10,
                onTap: () {
                  setState(() {
                    _state = 'login';
                  });
                },
                width: (ConstantVariable.deviceWidth(context) - 50) / 2,
              ),
              SizedBox(width: 10),
              ToogleText(
                text: 'Register',
                isSelected: _state == 'register',
                space: 10,
                onTap: () {
                  setState(() {
                    _state = 'register';
                  });
                },
                width: (ConstantVariable.deviceWidth(context) - 50) / 2,
              ),
            ],
          ),
          //content
          _state == 'login' ? _login(context) : _register(context),
        ],
      ),
    );
  }

  //* Login Function
  Widget _login(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //Email Input Field
                TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  cursorColor: Colors.purple,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      MdiIcons.emailOutline,
                    ),
                    labelText: 'E-mail',
                    hintText: 'max@gmail.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
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
                ),
                //Space
                SizedBox(height: 20),
                //PAssword Input Field
                TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  obscureText: _isSecureOnLogin,
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
                    prefixIcon: Icon(
                      MdiIcons.lockOutline,
                    ),
                    labelText: 'Password',
                    hintText: '*********',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: _isSecureOnLogin
                          ? Icon(MdiIcons.eyeOffOutline)
                          : Icon(MdiIcons.eyeOutline),
                      onPressed: () {
                        //change value of secure text
                        setState(() {
                          _isSecureOnLogin = !_isSecureOnLogin;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: _forgotPassword,
                  child: Text(
                    'Forgot your password ?',
                    style: ConstantVariable.textFont.copyWith(
                      color: ConstantVariable.accentColor3,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 35),
                //Loading while try to login
                //only show if login button clicked
                _isLoading
                    ? Container(
                        height: 50,
                        child: SpinKitThreeBounce(
                          color: Color(0xFFf283b7),
                          size: 15,
                        ),
                      )
                    //Button Login
                    : Container(
                        height: 50,
                        width: ConstantVariable.deviceWidth(context),
                        child: FlatButton(
                          color: Color(0xFFf283b7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: _tryLogin,
                          child: Text(
                            'Login',
                            style: ConstantVariable.textFont.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Text(
            '-or-',
            style: ConstantVariable.textFont.copyWith(
              color: ConstantVariable.accentColor3,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: 50,
            width: ConstantVariable.deviceWidth(context),
            child: OutlineButton.icon(
              icon: Icon(MdiIcons.facebook, color: Colors.blue),
              label: Text(
                'Sign in with facebook',
                style: ConstantVariable.textFont.copyWith(
                  color: Colors.blue,
                  fontSize: 14,
                ),
              ),
              borderSide: BorderSide(color: ConstantVariable.accentColor3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: _tryLoginWithFacebook,
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 50,
            width: ConstantVariable.deviceWidth(context),
            child: OutlineButton.icon(
              icon: Icon(MdiIcons.google, color: Colors.red),
              label: Text(
                'Sign in with facebook',
                style: ConstantVariable.textFont.copyWith(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
              borderSide: BorderSide(color: ConstantVariable.accentColor3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: _tryLoginWithGoogle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _register(BuildContext context) {
    return RegisterPage();
  }

  //Methode
  void _tryLogin() async {
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

  void _tryRegister() {
    //go to Register Page
    Navigator.pushNamed(context, '/register_page');
  }

  void _forgotPassword() {
    // coming Soon
    errorMessage(message: 'Coming Soon :D ', context: context);
  }

  void _tryLoginWithGoogle() {
    // coming Soon
    errorMessage(message: 'Coming Soon :D ', context: context);
  }

  void _tryLoginWithFacebook() {
    // coming Soon
    errorMessage(message: 'Coming Soon :D ', context: context);
  }
}
