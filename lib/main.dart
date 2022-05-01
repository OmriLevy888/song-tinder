import 'package:flutter/material.dart';
import 'package:song_tinder/home_page/home_page_widget.dart';
import 'package:song_tinder/conf_page/conf_page_widget.dart';
import 'package:song_tinder/settings_page/settings_page_widget.dart';
import 'package:song_tinder/home_page/song_provider.dart';
import 'package:song_tinder/home_page/dummy_music_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);


  // The SongProviderConfig should be updated from the value in the config page
  final _songProvider = SongProvider(
    musicServiceConfig: const MusicServiceConfig(service: MusicServices.spotify),
    songProviderConfig: SongProviderConfig(),
    musicService: DummyMusicService(),
  );

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
                  actions: <Widget>[SettingsButton(songProvider: _songProvider)],
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
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    HomePageWidget(songProvider: _songProvider),
                    ConfPageWidget(songProvider: _songProvider)
                  ],
                ))));
  }
}
