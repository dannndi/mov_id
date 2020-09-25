import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/models/register_user.dart';
import 'package:mov_id/core/models/user.dart';
import 'package:mov_id/core/services/base_services.dart';
import 'package:mov_id/ui/widgets/buble_background.dart';
import 'package:mov_id/ui/widgets/pick_image.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _formKey = GlobalKey<FormState>();
  var _isSecure = true;
  var _isSecure2 = true;

  var _fullName = '';
  var _email = '';
  var _password = '';
  var _confirmPassword = '';
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //floating action button still hide
      resizeToAvoidBottomInset: false,
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
          'Register your data ',
          style: ConstantVariable.textFont.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: //Button Register
          Container(
        height: 50,
        width: ConstantVariable.deviceWidth(context),
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: RaisedButton(
          elevation: 0,
          color: ConstantVariable.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: _goToRegisterPreferencePage,
          child: Text(
            'Next',
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
          margin: EdgeInsets.only(left: 24, right: 24, top: 24),
          child: Column(
            children: [
              //Image Picker
              _imagePicker(),
              //inputField
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    //Email Input Field
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      cursorColor: Colors.purple,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Name shoudn\'t be empty';
                        }
                        //if validated
                        return null;
                      },
                      onSaved: (value) {
                        _fullName = value.trim();
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(MdiIcons.accountOutline),
                        hintText: 'Maximali Zas',
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      cursorColor: Colors.purple,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'E-mail address shoudn\'t be empty';
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
                        labelText: 'E-mail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      obscureText: _isSecure,
                      maxLines: 1,
                      cursorColor: Colors.purple,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your password.';
                        } else if (value.length < 8) {
                          return 'Password should be at least 8 character !';
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
                    SizedBox(height: 15),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      obscureText: _isSecure2,
                      maxLines: 1,
                      cursorColor: Colors.purple,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your password.';
                        } else if (value.trim() != _password) {
                          return 'Confirmation password should be the same with password';
                        }
                        //if validated
                        return null;
                      },
                      onSaved: (value) {
                        _confirmPassword = value.trim();
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(MdiIcons.lockOutline),
                        labelText: 'Confirmation Password',
                        hintText: '*********',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: _isSecure2
                              ? Icon(MdiIcons.eyeOffOutline)
                              : Icon(MdiIcons.eyeOutline),
                          onPressed: () {
                            //change value of secure text
                            setState(() {
                              _isSecure2 = !_isSecure2;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              //check if keyboard is visible or not
              //..viewInsets.bottom > 0 means keyboard is visible
              MediaQuery.of(context).viewInsets.bottom > 0
                  ? SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imagePicker() {
    return Container(
      width: 175,
      height: 175,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ConstantVariable.primaryColor,
            ),
          ),
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: _image == null
                    ? AssetImage('assets/images/user_pic.png')
                    : FileImage(_image),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: _image == null ? _pickImage : _delImage,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  image: DecorationImage(
                    image: _image == null
                        ? AssetImage('assets/images/btn_add_photo.png')
                        : AssetImage('assets/images/btn_del_photo.png'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //Methode
  void _pickImage() {
    pickImage(
      context: context,
      image: (file) {
        setState(() {
          _image = file;
        });
      },
    );
  }

  void _delImage() {
    setState(() {
      _image = null;
    });
  }

  void _goToRegisterPreferencePage() {
    var _formState = _formKey.currentState;
    //save user input into variable
    _formState.save();
    if (_formState.validate()) {
      //Push to RegisterPreferencePage

      var registerUser = RegisterUser(
        name: _fullName,
        email: _email,
        password: _password,
        profilePicture: _image,
      );

      //Navigate Page
      Navigator.pushNamed(
        context,
        '/register_preference_page',
        arguments: registerUser,
      );
    }
  }
}
