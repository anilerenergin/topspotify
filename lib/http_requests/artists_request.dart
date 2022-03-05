import 'package:http/http.dart' as http;
import 'package:spotify_playground/spotify_sdk/spotify_sdk.dart';

Future<String> artistResponse(String authToken, String artistSetting) async {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $authToken',
  };

  var params = {
    'time_range': artistSetting,
    'limit': '30',
    'offset': '0',
  };
  var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

  var res = await http.get(
      Uri.parse('https://api.spotify.com/v1/me/top/artists?$query'),
      headers: headers);
  if (res.statusCode != 200) {
    return getAuth().then((value) {
      return artistResponse(value, artistSetting);
    });
  } else {
    return res.body;
  }
}
