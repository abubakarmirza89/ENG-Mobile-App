import 'package:engenglish/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

Future main() async {
  @override
  HttpClient client = HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
  HttpClient createHttpClient(SecurityContext context){
    return createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferences.getInstance().then(
        (prefs) {
      runApp(
        Eng(prefs),
      );
    },
  );
}








