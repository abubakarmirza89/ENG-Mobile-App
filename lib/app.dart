import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/prefernces.dart';
import 'package:engenglish/Screens/DashBoard/Dashboard.dart';
import 'package:engenglish/Screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Eng extends StatelessWidget {
  late final SharedPreferences prefs;
  Eng(this.prefs);
  SharedPreferences ?preferences;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(builder: (context, child) {
      return ScrollConfiguration(
        behavior: MyBehavior(),
        child: child!,
      );
    },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: ApplicationColors,
      ),
      home: _handleCurrentScreen(prefs),
    );
  }
  Widget _handleCurrentScreen(SharedPreferences prefs) {
    String? data = prefs.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA);
    preferences = prefs;
    if (data == null) {
      return SplashScreen();
    } else {
      return SplashScreen();
    }
  }
}
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

