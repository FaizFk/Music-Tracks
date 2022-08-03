import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/track.dart';

class TrackInfo extends StatefulWidget {
  Track track;

  TrackInfo(this.track);

  @override
  State<TrackInfo> createState() => _TrackInfoState();
}

class _TrackInfoState extends State<TrackInfo> {
  String? lyrics;

  bool isLoading = false;

  void getLyrics() async {
    try {
      setState(() {
        isLoading = true;
      });
      var response = await http.get(Uri.parse(
          'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${widget.track.trackId}&apikey=24c22b2ea7b1d7b215dd44922043e2d2'));
      Map<String, dynamic> data = json.decode(response.body);
      lyrics = data['message']['body']['lyrics']['lyrics_body'];
      setState(() {
        isLoading = false;
      });
      print(lyrics);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getLyrics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('${widget.track.trackName}'),
            Text('${widget.track.albumName}'),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Text('$lyrics')
          ],
        ),
      ),
    );
  }
}
