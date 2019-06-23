import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

abstract class Styles {
// Home page
  static const TextStyle counterTextNumber = TextStyle(
      fontFamily: 'Fjalla',
      color: CupertinoColors.destructiveRed,
      fontSize: 150,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      shadows: [
        Shadow(
          offset: Offset(0, 6),
          color: Color.fromARGB(30, 57, 57, 58),
        ),
      ]);
  static const TextStyle counterTextString = TextStyle(
    shadows: [
      Shadow(
        offset: Offset(0, 6),
        color: Color.fromARGB(30, 57, 57, 58),
      ),
    ],
    fontFamily: 'Fjalla',
    color: CupertinoColors.extraLightBackgroundGray,
    fontSize: 40,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

// New habit page

  static const BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 20, 30, 48),
        Color.fromARGB(255, 36, 59, 85),
      ],
    ),
  );
}
