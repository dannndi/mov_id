import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mov_id/core/base/shared_variable.dart';
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
        height: SharedVariable.deviceHeight(context),
        width: SharedVariable.deviceWidth(context),
        child: Stack(
          children: [
            _background(context),
            _content(context),
          ],
        ),
      ),
    );
  }

  Widget _background(BuildContext context) {
    return Positioned(
      right: -100,
      top: -100,
      child: Container(
        height: 250,
        width: 250,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: SharedVariable.primaryColor,
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
                style: SharedVariable.textFont.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //Space
              SizedBox(height: 250),
              //InputField and Button
              Container(
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
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
                                  }),
                            ),
                          ),
                          //Space
                          SizedBox(height: 15),
                          //Check if button clicked or not
                          _isLoading
                              //Loading while try to login
                              //only show if login button clicked
                              ? Container(
                                  height: 50,
                                  child: SpinKitThreeBounce(
                                    color: SharedVariable.primaryColor,
                                    size: 15,
                                  ),
                                )
                              //Button Login
                              : Container(
                                  height: 50,
                                  width: SharedVariable.deviceWidth(context),
                                  child: OutlineButton(
                                    //Colors outline in state not Clicked
                                    borderSide: BorderSide(
                                      color: SharedVariable.primaryColor,
                                      width: 2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPressed: _login,
                                    child: Text(
                                      'Login',
                                      style: SharedVariable.textFont.copyWith(
                                        color: SharedVariable.primaryColor,
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
                                style: SharedVariable.textFont,
                              ),
                              GestureDetector(
                                onTap: _forgotPassword,
                                child: Text(
                                  'Get it now !',
                                  style: SharedVariable.textFont.copyWith(
                                    color: SharedVariable.primaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 35),
                          Text('-Don\'t have an account ?-'),
                          SizedBox(height: 15),
                          //Button Register
                          Container(
                            height: 50,
                            width: SharedVariable.deviceWidth(context),
                            child: RaisedButton(
                              elevation: 0,
                              color: SharedVariable.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: _register,
                              child: Text(
                                'Register',
                                style: SharedVariable.textFont.copyWith(
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
                    //space to avoid bottom
                    SizedBox(height: 20)
                  ],
                ),
              )
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
    //check validation textformfield
    if (_formState.validate()) {
      //save user input into variable
      _formState.save();
      //try to login
      await Future.delayed(Duration(seconds: 2));
      //check login status and show message if error occured
      if (true) {
        //
      } else {
        //
        errorMessage(message: 'Yoyoooo', context: context);
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
