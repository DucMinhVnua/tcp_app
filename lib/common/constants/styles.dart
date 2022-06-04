import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workflow_manager/common/constants/colors.dart';

final kDefaultTextStyle = GoogleFonts.inter(
  textStyle: TextStyle(
      color: kBlack1,
      fontSize: 14.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400),
);

final kSmallWhiteTextStyle = GoogleFonts.inter(
  textStyle: TextStyle(
      color: Colors.white,
      fontSize: 11.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500),
);

final kMediumWhiteTextStyle = GoogleFonts.inter(
  textStyle: TextStyle(
      color: Colors.white,
      fontSize: 15.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700),
);

final kMediumBlackTextStyle = GoogleFonts.inter(
  textStyle: TextStyle(
      color: kBlack1,
      fontSize: 16.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700),
);

final kSmallBlackTextStyle = GoogleFonts.inter(
  textStyle: TextStyle(
      color: kBlack1,
      fontSize: 13.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400),
);
final kSmallGreyTextStyle = GoogleFonts.inter(
  textStyle: TextStyle(
      color: kGrey2,
      fontSize: 13.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400),
);
TextTheme buildTextTheme() {
  return TextTheme(
    headline1: kDefaultTextStyle,
    headline2: kDefaultTextStyle,
    headline3: kDefaultTextStyle,
    headline4: kDefaultTextStyle,
    headline5: kDefaultTextStyle,
    headline6: kDefaultTextStyle,
    subtitle1: kDefaultTextStyle,
    subtitle2: kDefaultTextStyle,
    bodyText1: kDefaultTextStyle,
    caption: kDefaultTextStyle,
    button: kDefaultTextStyle,
    overline: kDefaultTextStyle,
    bodyText2: kDefaultTextStyle,
  );
}
