import 'package:flutter/material.dart';

const redBackgroundColor = Color(0xffFFA194);

const greenBackgroundColor = Color(0xffB6E8A1);

const primaryColor = Color(0xffFF924D);

ThemeData customTheme() {
  return ThemeData(
    useMaterial3: false,
    // fontFamily: 'IBM',
    // primarySwatch: Colors.blue,
    // scaffoldBackgroundColor: backgroundColor,
    // appBarTheme: _buildAppBarTheme(),
  );
}

// AppBarTheme _buildAppBarTheme() {
//   return AppBarTheme(
//     backgroundColor: backgroundColor,
//     elevation: 0,
//     iconTheme: IconThemeData(color: Colors.black),
//     titleTextStyle: headingText().copyWith(color: primaryColor),
//   );
// }
