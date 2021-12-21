import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalizeIt() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

const kPrimaryColor = Color(0xff9976ff);
