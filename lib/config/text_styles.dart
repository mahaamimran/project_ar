import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyles {
  CustomTextStyles._();
  // app bar text style
  static TextStyle headingText1= _buildTextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  static TextStyle headingText2 = _buildTextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle headingText3 = _buildTextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  
  static TextStyle _buildTextStyle({
    // default values
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w800,
    Color color = Colors.white,
  }) {
    // change font from here
    return GoogleFonts.raleway(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}

// copyWith
extension TextStyleCopyWith on TextStyle {
  TextStyle copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      color: color ?? this.color,
    );
  }
}

