import 'package:flutter/material.dart';
import 'package:tb_jam/configurations/constants.dart';

ThemeData theme(context) {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xfafafaff),
    fontFamily: 'Roboto',
    textTheme: textTheme(),
    appBarTheme: appBarTheme(context),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    listTileTheme: const ListTileThemeData(selectedColor: kPrimaryColor),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black87,
      fontSize: 18,
    ),
  );
}

AppBarTheme appBarTheme(context) {
  return AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    centerTitle: false,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
    // ignore: deprecated_member_use
    textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
  );
}
