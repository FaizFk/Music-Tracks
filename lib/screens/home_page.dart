import 'package:flutter/material.dart';
import 'package:music_track/provider/data_provider.dart';
import 'package:provider/provider.dart';

import '../models/track.dart';
import '../widgets/track_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Track> trackList = [];

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<DataProvider>(context, listen: false).getHomeData().then(
        (value) => trackList =
            Provider.of<DataProvider>(context, listen: false).trackList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Provider.of<DataProvider>(context).hasError
            ? Center(child: Text('No connection'))
            : Provider.of<DataProvider>(context).isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: Provider.of<DataProvider>(context).trackCount,
                    itemBuilder: (context, index) {
                      return TrackTile(trackList[index]);
                    }),
      ),
    );
  }
}
