import 'package:flutter/material.dart';

import 'constans.dart';

ThemeData LightTheme() {
  return ThemeData(
      primarySwatch: Colors.grey,
      canvasColor: Colors.white,
      appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(
            color: Colors.black,
          )),
      iconTheme: const IconThemeData(color: Colors.black54),
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 30, color: Colors.black),
        bodyText1: TextStyle(
          fontSize: 16.0,
        ),
        bodyText2: TextStyle(
          fontSize: 20,
          color: Colors.grey,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 100.0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: defaultColor,
          unselectedItemColor: Colors.blueGrey));
}

ThemeData darkTheme() {
  return ThemeData(
      primarySwatch: Colors.grey,
      canvasColor: Colors.white12,
      cardColor: Colors.white12,

      appBarTheme: const AppBarTheme(
          color: Colors.white12,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(
            color: Colors.white,
          )),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: ThemeData.dark().textTheme.copyWith(
        headline1: const TextStyle(fontSize: 30, color: Colors.white),
        bodyText1: const TextStyle(
          fontSize: 16.0,
            color: Colors.white
        ),
        bodyText2: const TextStyle(
          fontSize: 20,
          color: Colors.grey,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white12,
          elevation: 100.0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: defaultColor,
          unselectedItemColor: Colors.blueGrey));
}
