import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_playground/screens/homepage.dart';
import 'package:spotify_playground/spotify_sdk/spotify_sdk.dart';

class SpotifyAuthPage extends StatefulWidget {
  const SpotifyAuthPage({Key? key}) : super(key: key);
  @override
  _SpotifyAuthPageState createState() => _SpotifyAuthPageState();
}

class _SpotifyAuthPageState extends State<SpotifyAuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const Padding(
              padding:  EdgeInsets.all(16.0),
              child: Text(
                "See your top tracks and artists from Spotify!",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
          const  SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => connectSpotifyApp(),
              child: Container(
                height: 40,
                width: 200,
                color: Colors.green,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        FontAwesomeIcons.spotify,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Login With Spotify",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  connectSpotifyApp() async {
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);

  getAuth().then((value) => Get.to(HomePage(
        authToken: value,trackLabelIndex: 0,artistLabelIndex: 0,
      )));
  }
}
