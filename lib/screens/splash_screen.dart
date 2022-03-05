import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_playground/spotify_sdk/spotify_sdk.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

getToHomePage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int trackLabelIndex = prefs.getInt('trackLabelIndex') ?? 0;
  int artistLabelIndex = prefs.getInt('artistLabelIndex') ?? 0;
  const Duration(seconds: 3);
  getAuth().then((value) => Get.to(HomePage(
      authToken: value,
      trackLabelIndex: trackLabelIndex,
      artistLabelIndex: artistLabelIndex)));
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    getToHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Image.asset(
          "assets/headphones.png",
          color: Colors.white,
        ),
      ),
    );
  }
}
