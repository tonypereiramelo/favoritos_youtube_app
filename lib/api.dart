import 'dart:convert';
import 'package:favoritos_youtube_app/models/video.dart';
import 'package:http/http.dart' as http;

const API_KEY = "AIzaSyCYLORwsO9u1KXPx2cwNdkP0HvxVZFmUn8";

class Api {
  String? _search;
  String? _nextToken;
  Video? video;

  search(String search) async {
    _search = search;
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"));
    return decode(response);
  }

  nextPage() async {
    _nextToken = video!.nPage;
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"));
    return decode(response);
  }

  List<Video>? decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      //_nextToken = decoded("nextPageToken");
      List<Video> videos = decoded["items"].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();
      return videos;
    } else {
      throw Exception("Failed to load Videos");
    }
  }
}
