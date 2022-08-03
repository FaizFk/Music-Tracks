import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:music_track/models/track.dart';

class DataProvider with ChangeNotifier {
  String apiKey = '24c22b2ea7b1d7b215dd44922043e2d2';
  bool isLoading = false;
  List<Track> _trackList = [];

  int get trackCount {
    return _trackList.length;
  }

  List<Track> get trackList {
    return [..._trackList];
  }

  Future<void> getHomeData() async {
    final String url =
        'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=$apiKey';
    try {
      isLoading = true;
      var response = await http.get(Uri.parse(url));
      Map<String, dynamic> data = json.decode(response.body);
      List trackListJson = data['message']['body']['track_list'];
      _trackList = trackListJson.map((item) => Track.fromJson(item)).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Some Errrrrrrrrrrrrrrrrrrrrrrrrrrrrrror Found $e');
      notifyListeners();
    }
  }
}
