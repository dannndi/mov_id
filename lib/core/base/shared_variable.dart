import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedVariable {
  //Device Screen Size
  static double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  //Colors used
  static Color primaryColor = Color(0xFF503E9D);
  static Color accentColor1 = Color(0xFF2C1F63);
  static Color accentColor2 = Color(0xFFFBD460);
  static Color accentColor3 = Color(0xFFADADAD);

  //font
  static TextStyle textFont = GoogleFonts.montserrat().copyWith(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
  static TextStyle numbberFont = GoogleFonts.openSans().copyWith(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );

  //API
}
