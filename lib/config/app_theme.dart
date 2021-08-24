import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const Color nearlyDarkBlue = Color(0xFF2633C5);
  static const Color grey = Color(0xFF3A5160);
  static const Color brown = Color(0xFF252F23);
  static const Color nearlyYellow = Color(0xffffca08);
  static const Color yellow38 = Color(0xDDFF8C00);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyWhite = Color(0xFFF8F8FF);
  static const Color white38 = Color(0xFFe7e7e8);
  static const Color white70 = Color(0xFFd8d7da);
  static const Color white80 = Color(0xFFd9d9d9);
  static const Color whiteDark = Color(0xFFB0B1A1);
  static const Color background = Color(0xFFF2F3F8);
  static const Color black = Color(0xFF000000);
  static const Color nearlyBlack = Color(0xFF191919);
  static const Color black38 = Color(0xff837f93);
  static const Color black26 = Color(0xff9b98aa);
  static const Color black90 = Color(0xff918f95);
  static const Color black70 = Color(0xFf34323d);
  static const Color black80 = Color(0xFF222029);
  static const Color pink38 = Color(0xDDFF0080);
  static const Color blu38 = Color(0xFF8983F7);
  static const Color blu80 = Color(0xFFA3DAFB);
  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color blue = Color(0xFF0000ff);
  static const Color red = Color(0xFFFF0000);
  static const Color nearlyBrown = Color(0xFF4D4B57);
  static const String fontNameWorkSans = 'WorkSans';
  static const String fontName = 'Roboto';

  static const double iconLogo2 = 100.0;


  static const double heightButton1 = 42.0;
  static const double heightButton2 = 80.0;

  static const double widthButton1 = 200.0;

  static const double heightHeadCard1 = 50.0;
  static const double heightHeadCard2 = 100.0;

  static const double radiusAvatar = 100.0;
  static const double radiusCard1 = 20.0;
  static const double radiusButton = 100.0;

  static const double sizeIcon1 = 30.0;
  static const double sizeIcon2 = 60.0;

  static const EdgeInsets paddingLeftRightScreenApp1 =
      EdgeInsets.only(left: 10, right: 10);
  static const EdgeInsets paddingLeftRightScreenApp2 =
  EdgeInsets.only(left: 20, right: 20);

  static const EdgeInsets paddingTopListViewScreenApp1 = EdgeInsets.only(
    top: 10,
  );
  static const EdgeInsets paddingBottomCardListViewScreenApp1 = EdgeInsets.only(
    bottom: 20,
  );
  static const EdgeInsets paddingTopBottomCardScreenApp1 = EdgeInsets.only(
    bottom: 10,
    top: 10
  );
  static EdgeInsets paddingLeftRightTopScreen1 =
      EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10);
  static EdgeInsets paddingLeftRightTopScreen2 =
  EdgeInsets.only(
      left: 30,
      right: 30,
      top: 30);

  static const EdgeInsets paddingAllScreen1 =
      EdgeInsets.all(10);
  static const EdgeInsets paddingAllScreen2 =
  EdgeInsets.all(30);
  static const EdgeInsets paddingLeftScreen =
      EdgeInsets.only(left: 20);
  static const EdgeInsets paddingRightScreen =
      EdgeInsets.only(right: 20);
  static const EdgeInsets paddingTopScreen =
  EdgeInsets.only(top: 10);

  static const EdgeInsets marginTopScreen = EdgeInsets.only(top: 30);
  static const EdgeInsets marginLeftScreen = EdgeInsets.only(left: 30);
  static const EdgeInsets marginScreenDetailSpeaker1 =
      EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5);
  static const EdgeInsets marginLeftRightSpeaker1 =
  EdgeInsets.only(left: 5, right: 5,);

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title1,
    subtitle2: subtitle1,
    bodyText1: body1,
    bodyText2: body2,
    caption: caption,
  );
  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );
  static const TextStyle titleAppBar1 = TextStyle(
    fontFamily: fontName,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.4,
    height: 0.9,
    color: white,
  );
  static const TextStyle titleAppBar2 = TextStyle(
    fontFamily: fontName,
    fontSize: 45,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.4,
    height: 0.9,
    color: white,
  );

  static const TextStyle textStyleWhite1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.27,
    color: white,
  );
  static const TextStyle white10Bold = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 10,
    letterSpacing: 0.27,
    color: white,
  );
  static const TextStyle textStyleWhite2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 30,
    letterSpacing: 0.27,
    color: white,
  );

  static const TextStyle textWhite18Bold1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w900,
    fontSize: 18,
    letterSpacing: 0.27,
    color: white,
  );
  static const TextStyle textWhite30Bold2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w900,
    fontSize: 30,
    letterSpacing: 0.27,
    color: white,
  );

  static const TextStyle textBlu = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w100,
    fontSize: 16,
    letterSpacing: 0.27,
    color: blue,
  );
  static const TextStyle textBluBold = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.27,
    color: blue,
  );
  static const TextStyle textRedBold500_1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.27,
    color: red,
  );
  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );
  static const TextStyle headlineYellow = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 30,
    letterSpacing: 0.27,
    color: nearlyYellow,
  );
  static const TextStyle title1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 25,
    letterSpacing: 0.18,
    color: black,
  );
  static const TextStyle title2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 50,
    letterSpacing: 0.18,
    color: black,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontSize: 12,
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.04,
    color: darkerText,
  );
  static const TextStyle subtitle2 = TextStyle(
    fontSize: 20,
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.04,
    color: darkerText,
  );

  static const TextStyle subtitleBold1 = TextStyle(
    fontSize: 10,
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.04,
    color: darkerText,
  );
  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkerText,
  );
  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkerText,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontSize: 12,
    letterSpacing: 0.2,
    fontWeight: FontWeight.w400,
    color: lightText,
  );
  static const TextStyle captionBlack = TextStyle(
    fontFamily: fontName,
    fontSize: 12,
    letterSpacing: 0.2,
    fontWeight: FontWeight.w500,
    color: black,
  );
  static const TextStyle captionBlack1 = TextStyle(
    fontFamily: fontName,
    fontSize: 16,
    letterSpacing: 0.2,
    fontWeight: FontWeight.w500,
    color: black,
  );
  static const TextStyle textRedBold500_2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 30,
    letterSpacing: 0.27,
    color: red,
  );
  static const TextStyle captionBlack2 = TextStyle(
      fontFamily: fontName,
      fontSize: 20,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500,
      color: black);
}
