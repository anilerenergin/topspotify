import 'package:http/http.dart' as http;
import 'package:spotify_playground/spotify_sdk/spotify_sdk.dart';

Future<String> trackResponse(String authToken,String trackSetting) async {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $authToken',
  };

  var params = {
    'time_range': trackSetting,
    'limit': '30',
    'offset': '0',
  };
  var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

  var response = await http.get(
      Uri.parse('https://api.spotify.com/v1/me/top/tracks?$query'),
      headers: headers);
  if (response.statusCode != 200) {
    return getAuth().then((value) {
      return trackResponse(value,trackSetting);
    });
  } else {
    return response.body;
  }
}
