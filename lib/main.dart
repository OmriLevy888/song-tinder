import 'package:flutter/material.dart';
import 'package:song_tinder/home_page/home_page_widget.dart';
import 'package:song_tinder/conf_page/conf_page_widget.dart';
import 'package:song_tinder/settings_page/settings_page_widget.dart';

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
          shadowColor: Colors.black.withAlpha(60),
        ),
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  title: const Text('Song Tinder'),
                  actions: <Widget>[SettingsButton()],
                ),
                bottomNavigationBar: const BottomAppBar(
                    color: Colors.blue,
                    child: TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.home)),
                        Tab(icon: Icon(Icons.settings_applications))
                      ],
                    )),
                body: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    HomePageWidget(),
                    ConfPageWidget()
                  ],
                ))));
  }
}
