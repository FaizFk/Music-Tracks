import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_track/screens/track_info_screen.dart';
import '../models/track.dart';

class TrackTile extends StatelessWidget {
  Track track;

  TrackTile(this.track);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrackInfo(track),
            ),
          );
        },
        leading: Icon(Icons.library_music_outlined),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${track.trackName}'),
            Text(
              '${track.albumName}',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ],
        ),
        trailing: Text(
          '${track.artistName}',
          style: TextStyle(color: Colors.grey[700]),
        ),
      ),
    );
  }
}
