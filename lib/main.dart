// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_playground/screens/splash_screen.dart';
import 'package:spotify_playground/screens/spotifty_auth_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;


  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatefulWidget {
  MyApp({
    required this.isLoggedIn,
  });
  bool isLoggedIn;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Top Spotify',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            widget.isLoggedIn ? const SplashScreen() : const SpotifyAuthPage());
  }
}
