import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConstantVariable {
  //* Device Screen Size
  static double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  //* Colors used
  static Color primaryColor = Color(0xFF83bbf2);
  static Color accentColor1 = Color(0xFF6ba2d6);
  static Color accentColor2 = Color(0xFFf283b7);
  static Color accentColor3 = Color(0xFFAEB1C6);
  static Color accentColor4 = Color(0xFF5a7fb8);

  //* font
  static TextStyle textFont = GoogleFonts.montserrat().copyWith(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
  static TextStyle numbberFont = GoogleFonts.openSans().copyWith(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );

  //* API
  static String apiKey = '9c4321103577c8fe48972c0207dc1cba';
  static String imageBaseUrl = 'https://image.tmdb.org/t/p/%size%/%path%';
  static String baseUrl = "https://api.themoviedb.org/3/movie/%type%";

  //* etc
  static File profilePictureToUpdate;
}
