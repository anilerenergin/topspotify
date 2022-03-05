// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_playground/models/color.dart';
import 'package:spotify_playground/models/track_model.dart';
import 'package:spotify_playground/screens/spotifty_auth_page.dart';
import 'package:spotify_playground/spotify_sdk/spotify_sdk.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:get/get.dart';
import 'package:spotify_playground/http_requests/tracks_request.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';
import '../http_requests/artists_request.dart';
import '../models/artist_model.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.authToken,required this.trackLabelIndex,required this.artistLabelIndex}) : super(key: key);
  String authToken;
  int trackLabelIndex;
  int artistLabelIndex;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final ColorIndex colorIndex = Get.put(ColorIndex());
  var trackList;
  var artistList;
  var trackSetting;
  var artistSetting;


  @override
  _HomePageState();

  Future<void> populateTracks(String authToken, String trackSetting) async {
    var responseBody = await trackResponse(authToken, trackSetting);
    setState(() {
      trackList = tracksFromJson(responseBody).items;
    });
  }

  Future<void> populateArtists(String authToken, String artistSetting) async {
    var responseBody = await artistResponse(authToken, artistSetting);
    setState(() {
      artistList = artistsFromJson(responseBody).items;
    });
  }
 

  @override
  void initState() {
   
    super.initState();
    if (widget.trackLabelIndex == 0) {
      trackSetting = "short_term";
    } else if (widget.trackLabelIndex == 1) {
      trackSetting = "medium_term";
    } else {
      trackSetting = "long_term";
    }
    if (widget.artistLabelIndex == 0) {
      artistSetting = "short_term";
    } else if (widget.artistLabelIndex == 1) {
      artistSetting = "medium_term";
    } else {
      artistSetting = "long_term";
    }

    connect();
    populateArtists(widget.authToken, artistSetting)
        .whenComplete(() => populateTracks(widget.authToken, trackSetting));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        bottomNavigationBar: _bottomAppBar(height, width),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              disconnect();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('isLoggedIn');

              Get.to(const SpotifyAuthPage());
            },
            icon:const Icon(Icons.logout),
            color: Colors.grey[900],
          ),
          actions: [
            IconButton(
                onPressed: ()=>showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Settings"),
                          content: Column(
                    
            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Get Top Tracks:",
                                  ),
                                  const SizedBox(height:3),
                                  ToggleSwitch(
                                    activeBgColor: const [Colors.green],
                                    initialLabelIndex: widget.trackLabelIndex,
                                    totalSwitches: 3,
                                    labels: const [
                                      "Weeks",
                                      "Months",
                                      "Lifetime"
                                    ],
                                    onToggle: (index)async {
                                      if (index == 0) {
                                        trackSetting = "short_term";
                                      } else if (index == 1) {
                                        trackSetting = "medium_term";
                                      } else {
                                        trackSetting = "long_term";
                                      }
                                      SharedPreferences prefs =await SharedPreferences.getInstance(); 
                                      setState(() {
                                        populateTracks(
                                            widget.authToken, trackSetting);
                                        widget.trackLabelIndex = index!;
                                        prefs.setInt('trackLabelIndex', index);
                                      });
                    
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 7,),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text("Get Top Artists:"),
                                           const SizedBox(height:3),
                                  ToggleSwitch(
                                    activeBgColor: const [Colors.green],
                                    initialLabelIndex:widget.artistLabelIndex,
                                    totalSwitches: 3,
                                    labels: const [
                                      "Weeks",
                                      "Months",
                                      "Lifetime"
                                    ],
                                    onToggle: (index)async {
                                      if (index == 0) {
                                        artistSetting = "short_term";
                                      } else if (index == 1) {
                                        artistSetting = "medium_term";
                                      } else {
                                        artistSetting = "long_term";
                                      }
                                       SharedPreferences prefs =await SharedPreferences.getInstance(); 

                                      setState(() {
                                        populateArtists(widget.authToken,
                                            artistSetting);
                                        widget.artistLabelIndex = index!;
                                            prefs.setInt('artistLabelIndex', index);
                                      });
                               
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: const Text("Apply"),
                              onPressed: () {
                                Get.back();
                              },
                            )
                          ],
                        );
                      },
                    ),
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.black,
                ))
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text("Top Spotify",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    colorIndex.colorIndex = RxInt(value.toInt());
                  });
                },
                controller: _pageController,
                children: <Widget>[
                  _firstPage(height, width, trackList),
                  _secondPage(height, width, artistList),
                ],
              ),
            ),
            _player(height,width)
          ],
        ));
  }

  Widget _bottomAppBar(double height, double width) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {

              setState(() {
                colorIndex.colorIndex = RxInt(0);
              });
              _pageController.animateToPage(0,
                  duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
            },
            child: Obx(
              () => Container(
                  height: height / 12,
                  width: width / 2,
                  color: colorIndex.colorIndex == RxInt(0)
                      ? Colors.green
                      : Colors.grey[900],
                  child: Center(
                      child: Text("Tracks",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorIndex.colorIndex == RxInt(0)
                                  ? Colors.grey[900]
                                  : Colors.white)))),
            ),
          ),
          GestureDetector(
            onTap: () {
              _pageController.animateToPage(1,
                  duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
              setState(() {
                colorIndex.colorIndex = RxInt(1);
              });
            },
            child: Obx(
              () => Container(
                  height: height / 12,
                  width: width / 2,
                  color: colorIndex.colorIndex == RxInt(1)
                      ? Colors.green
                      : Colors.grey[900],
                  child: Center(
                      child: Text("Artists",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorIndex.colorIndex == RxInt(1)
                                  ? Colors.grey[900]
                                  : Colors.white)))),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _secondPage(height, width, list) {
  return Column(
    children: [
      Container(
        width: width,
        height: height / 20,
        color: Colors.white,
        child: const Center(
          child: Text("Your Favorite Artists",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      list == null
          ? Column(
              children:const [
               SizedBox(height: 100),
              CircularProgressIndicator(),
              ],
            )
          : Expanded(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          launch(list[index].uri);
                        },
                        child: ListTile(
                          tileColor: Colors.grey[200],
                          leading: SizedBox(
                            width: 80,
                            height: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  (index + 1).toString() + ".",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: Image.network(
                                          list[index].images[1].url,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title: Text(list[index].name.toString()),
                          subtitle: Text(list[index].genres[0]),
                        ),
                      ),
                    );
                  }),
            ),
    ],
  );
}

Widget _firstPage(
  height,
  width,
  trackList,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        width: width,
        height: height / 20,
        color: Colors.white,
        child: const Center(
          child: Text("Your Favorite Tracks",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      trackList == null
          ? Column(
              children: const [
                SizedBox(height: 100),
                CircularProgressIndicator(),
              ],
            )
          : Expanded(
              child: ListView.builder(
                  itemCount: trackList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          play(trackList[index].uri);
                        },
                        child: ListTile(
                          tileColor: Colors.grey[200],
                          leading: SizedBox(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  (index + 1).toString() + ".",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Image.network(
                                    trackList[index].album.images[1].url),
                              ],
                            ),
                          ),
                          title: Text(trackList[index].name),
                          subtitle: Text(trackList[index].artists[0].name),
                        ),
                      ),
                    );
                  }),
            ),
    ],
  );
}

StreamBuilder<PlayerState> _player(height, width) {
  return StreamBuilder<PlayerState>(
      stream: SpotifySdk.subscribePlayerState(),
      builder: (context, snapshot) {

        return snapshot.data!=null&&snapshot.data!.track!=null
            ? Container(
                width: width,
                height: height / 8,
                color: Colors.grey[900],
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: snapshot.data?.track!= null
                                  ? SizedBox(
                                      height: height / 6,
                                      child: spotifyImageWidget(
                                          snapshot.data!.track!.imageUri))
                                  : SizedBox(
                                      height: height / 6,
                                      child: const CircularProgressIndicator())),
                          SizedBox(
                            width: width / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.track!.name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data!.track!.artist.name.toString(),
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.7)),
                                  overflow: TextOverflow.clip,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 30.0, top: 10, bottom: 10),
                        child: GestureDetector(
                            onTap: () =>
                                snapshot.data!.isPaused ? resume() : pause(),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(100)),
                              child: snapshot.data!.isPaused
                                  ? const Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.pause,
                                      color: Colors.white,
                                    ),
                            )),
                      ),
                    ]),
              )
            : const SizedBox.shrink();
      });
}

