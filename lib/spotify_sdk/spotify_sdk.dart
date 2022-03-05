// ignore_for_file: prefer_const_constructors
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

Future getPlayerState() async {
  try {
    return await SpotifySdk.getPlayerState();
  } on PlatformException catch (e) {
    setStatus(e.code, message: e.message);
  } on MissingPluginException {
    setStatus('not implemented');
  }
}

Widget spotifyImageWidget(ImageUri image) {
  return FutureBuilder(
      future:
          SpotifySdk.getImage(imageUri: image, dimension: ImageDimension.small),
      builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          return Image.memory(snapshot.data!);
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height/10,
            width: MediaQuery.of(context).size.height/10,
            child: CircularProgressIndicator());
        }
      });
}

Future<void> connect() async {
  await SpotifySdk.connectToSpotifyRemote(
    clientId: 'your client id here',
    redirectUrl: 'your redirect url here', //http://localhost/
  );
}

Future<void> disconnect() async {
  try {
    var result = await SpotifySdk.disconnect();
    setStatus(result ? 'disconnect successful' : 'disconnect failed');
  } on PlatformException catch (e) {
    setStatus(e.code, message: e.message);
  } on MissingPluginException {
    setStatus('not implemented');
  }
}

Future<void> play(uri) async {
  await SpotifySdk.play(spotifyUri: uri);
}

Future<String> getAuth() async {
  return await SpotifySdk.getAuthenticationToken(
      clientId: 'your client id here',
      redirectUrl: 'your redirect url here', //http://localhost/
      scope:
          "app-remote-control,user-modify-playback-state,playlist-read-private,user-top-read,user-read-playback-state");
}

void setStatus(String code, {String? message}) {
  var text = message ?? '';
}

Future<void> skipPrevious() async {
  try {
    await SpotifySdk.skipPrevious();
  } on PlatformException catch (e) {
    setStatus(e.code, message: e.message);
  } on MissingPluginException {
    setStatus('not implemented');
  }
}

Future<void> resume() async {
  try {
    await SpotifySdk.resume();
  } on PlatformException catch (e) {
    setStatus(e.code, message: e.message);
  } on MissingPluginException {
    setStatus('not implemented');
  }
}

Future<void> skipNext() async {
  try {
    await SpotifySdk.skipNext();
  } on PlatformException catch (e) {
    setStatus(e.code, message: e.message);
  } on MissingPluginException {
    setStatus('not implemented');
  }
}

Future<void> pause() async {
  try {
    await SpotifySdk.pause();
  } on PlatformException catch (e) {
    setStatus(e.code, message: e.message);
  } on MissingPluginException {
    setStatus('not implemented');
  }
}

Future<void> setRepeatMode(RepeatMode repeatMode) async {
  try {
    await SpotifySdk.setRepeatMode(
      repeatMode: repeatMode,
    );
  } on PlatformException catch (e) {
    setStatus(e.code, message: e.message);
  } on MissingPluginException {
    setStatus('not implemented');
  }
}

Future<void> setShuffle(bool shuffle) async {
  try {
    await SpotifySdk.setShuffle(
      shuffle: shuffle,
    );
  } on PlatformException catch (e) {
    setStatus(e.code, message: e.message);
  } on MissingPluginException {
    setStatus('not implemented');
  }
}
