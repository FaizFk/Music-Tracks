import 'package:flutter/material.dart';
import 'package:music_track/screens/track_info_screen.dart';
import '../models/track.dart';

class TrackTile extends StatelessWidget {
  Track track;
  TrackTile(this.track);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrackInfo(track),
          ),
        );
      },
      child: ListTile(
        title: Text('${track.trackName}'),
      ),
    );
  }
}
