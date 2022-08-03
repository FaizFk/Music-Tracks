import 'package:flutter/material.dart';
import 'package:music_track/provider/data_provider.dart';
import 'package:music_track/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: HomePage(),
      ),
    );
  }
}
