import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';
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
  bool hasError = false;

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
      setState(() {
        hasError = true;
      });
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
        child: hasError
            ? Center(
                child: Text('No Connection'),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              '${widget.track.trackName}',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red[400]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularPercentIndicator(
                                radius: 40.0,
                                lineWidth: 6.0,
                                percent: (widget.track.rating ?? 0) / 100,
                                center: Text(
                                  '${widget.track.rating}/100',
                                  style: TextStyle(fontSize: 15),
                                ),
                                progressColor: Colors.green,
                                footer: Text(
                                  'Rating',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Album Name',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      '${widget.track.albumName}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Explicit',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      '${widget.track.isExplicit}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Lyrics',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              '$lyrics',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.blue[100]),
                            )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
