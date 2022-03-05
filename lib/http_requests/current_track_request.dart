import 'package:http/http.dart' as http;
import 'package:spotify_playground/spotify_sdk/spotify_sdk.dart';

Future<String> currentTrackRequest(authToken) async {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $authToken',
  };

  var res = await http.get(Uri.parse('https://api.spotify.com/v1/me/player/currently-playing'), headers: headers);
  if(res.statusCode==200){
    return res.body;
  }else if(res.statusCode==204){
return "";
}
  else{
return getAuth().then((value) => currentTrackRequest(value));
  }
}