import 'package:flutter/material.dart';
import 'package:thingsboard_app/utils/transition/page_transitions.dart';

const int _tsPrimaryColorValue = 0xFFff5722;
const Color _tsPrimaryColor = Color(_tsPrimaryColorValue);
const Color _tsSecondaryColor = Color(0xFFf4511e);
const Color _tsDarkPrimaryColor = Color(0xFFff844c);
const int _tsTextColorValue = 0xFF282828;
const Color _tsTextColor = Color(_tsTextColorValue);

var tsTypography = Typography.material2018();

const tsMatDeepOrange = MaterialColor(
  _tsPrimaryColorValue,
  <int, Color> {
    50: Color(0xFFfbe9e7),
    100: Color(0xFFffccbc),
    200: Color(0xFFffab91),
    300: Color(0xFFff8a65),
    400: Color(0xFFff7043),
    500: _tsPrimaryColor,
    600: _tsSecondaryColor,
    700: Color(0xFFe64a19),
    800: Color(0xFFd84315),
    900: Color(0xFFbf360c),
  }
);

const tsDarkMatDeepOrange = MaterialColor(
    _tsPrimaryColorValue,
    <int, Color> {
      50: Color(0xFFfbe9e7),
      100: Color(0xFFffccbc),
      200: Color(0xFFffab91),
      300: Color(0xFFff8a65),
      400: Color(0xFFff7043),
      500: _tsDarkPrimaryColor,
      600: _tsSecondaryColor,
      700: Color(0xFFe64a19),
      800: Color(0xFFd84315),
      900: Color(0xFFbf360c),
    }
);

ThemeData tsTheme = ThemeData(
    primarySwatch: tsMatDeepOrange,
    scaffoldBackgroundColor: Color(0xFFFAFAFA),
    textTheme: tsTypography.black,
    primaryTextTheme: tsTypography.black,
    typography: tsTypography,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: _tsTextColor,
        iconTheme: IconThemeData(
            color: _tsTextColor
        ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: _tsPrimaryColor,
        unselectedItemColor: _tsPrimaryColor.withAlpha((255 * 0.38).ceil()),
        showSelectedLabels: true,
        showUnselectedLabels: true
    ),
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.iOS: FadeOpenPageTransitionsBuilder(),
      TargetPlatform.android: FadeOpenPageTransitionsBuilder(),
    })
);


ThemeData tsDarkTheme = ThemeData(
    primarySwatch: tsDarkMatDeepOrange,
    brightness: Brightness.dark
);
