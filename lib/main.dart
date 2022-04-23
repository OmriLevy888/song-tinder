import 'package:flutter/material.dart';
import 'package:song_tinder/home_page/home_page_widget.dart';
import 'package:song_tinder/conf_page/conf_page_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Song Tinder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                    bottom: const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.home)),
                    Tab(icon: Icon(Icons.settings))
                  ],
                )),
                body: const TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    HomePageWidget(title: "Song Tinder"),
                    ConfPageWidget()
                  ],
                ))));
  }
}
