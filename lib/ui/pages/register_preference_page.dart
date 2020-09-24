import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/models/register_user.dart';
import 'package:mov_id/ui/widgets/buble_background.dart';
import 'package:mov_id/ui/widgets/error_message.dart';
import 'package:mov_id/ui/widgets/selectable_box.dart';

class RegisterPreferencePage extends StatefulWidget {
  @override
  _RegisterPreferencePageState createState() => _RegisterPreferencePageState();
}

class _RegisterPreferencePageState extends State<RegisterPreferencePage> {
  RegisterUser _registerUser;
  //list language
  List<String> languages = [
    'English',
    'Indonesia',
    'Japanese',
    'Korean',
  ];

  //List prefered genres
  List<String> preferedGenres = [
    'Action',
    'Adventure',
    'Comedi',
    'Education',
    'Fantasy',
    'Horror',
    'History',
    'Mature',
    'Psycolog',
    'War',
  ];

  String selectedLanguage = 'Indonesia';
  List<String> selectedPreferedGenres = [];
  @override
  Widget build(BuildContext context) {
    //get Data from previws page
    _registerUser = ModalRoute.of(context).settings.arguments;

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
          'Select your preference',
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
      floatingActionButton: Container(
        height: 50,
        width: ConstantVariable.deviceWidth(context),
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: RaisedButton(
          elevation: 0,
          color: ConstantVariable.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
            _goToRegisterConfirmationPage(context);
          },
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
      child: Container(
        margin: EdgeInsets.fromLTRB(24, 10, 24, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._selectLanguage(context),
              SizedBox(height: 30),
              ..._selectPreferenceGenre(context),
              SizedBox(height: 150),
              //Button Register
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _selectLanguage(BuildContext context) {
    return [
      Text(
        'Select your language',
        style: ConstantVariable.textFont.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 20),
      Wrap(
        //spacing =  space between widget in row
        spacing: 24,
        //runSpacing = space between row
        runSpacing: 24,
        children: [
          ...languages
              .map(
                (language) => SelectableBox(
                  height: 60,
                  width: (ConstantVariable.deviceWidth(context) - 72) / 2,
                  title: Center(
                    child: Text(language),
                  ),
                  isSelected: selectedLanguage == language,
                  onTap: () {
                    if (selectedLanguage == language) {
                      selectedLanguage = '';
                    } else {
                      selectedLanguage = language;
                    }
                    //Refresh Screen
                    setState(() {});
                  },
                ),
              )
              .toList(),
        ],
      ),
    ];
  }

  List<Widget> _selectPreferenceGenre(BuildContext context) {
    return [
      Text(
        'Select prefered genre',
        style: ConstantVariable.textFont.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 20),
      Wrap(
        spacing: 24,
        runSpacing: 24,
        children: preferedGenres
            .map(
              (genre) => SelectableBox(
                height: 60,
                width: (ConstantVariable.deviceWidth(context) - 72) / 2,
                title: Center(
                  child: Text(genre),
                ),
                isSelected: selectedPreferedGenres.contains(genre),
                onTap: () {
                  if (selectedPreferedGenres.contains(genre)) {
                    selectedPreferedGenres.remove(genre);
                  } else {
                    selectedPreferedGenres.add(genre);
                  }
                  //Refresh Screen
                  setState(() {});
                },
              ),
            )
            .toList(),
      )
    ];
  }

  //
  void _goToRegisterConfirmationPage(BuildContext context) {
    if (selectedLanguage == '' || selectedLanguage == null) {
      errorMessage(message: 'Please select language first !', context: context);
    } else if (selectedPreferedGenres.length < 4) {
      errorMessage(message: 'Must choose 4 or more genre ', context: context);
    } else {
      // Navigate Page
      Navigator.pushNamed(
        context,
        '/register_confirmation_page',
        arguments: _registerUser.copyWith(
          selectedLanguage: selectedLanguage,
          selectedGenres: selectedPreferedGenres,
        ),
      );
    }
  }
}
