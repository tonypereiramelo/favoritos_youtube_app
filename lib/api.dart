import 'dart:convert';
import 'package:favoritos_youtube_app/models/video.dart';
import 'package:http/http.dart' as http;

const API_KEY = "AIzaSyCYLORwsO9u1KXPx2cwNdkP0HvxVZFmUn8";

class Api {
  search(String search) async {
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"));
    decode(response);
  }

  List<Video>? decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);

      List<Video> videos = decoded["items"].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();
      return videos;
    } else {
      throw Exception("Failed to load Videos");
    }
  }
}
