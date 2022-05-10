import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:song_tinder/home_page/home_page_widget.dart';
import 'package:song_tinder/conf_page/conf_page_widget.dart';
import 'package:song_tinder/settings_page/settings_page_widget.dart';
import 'package:song_tinder/widgets/widgets.dart';

void main() {
  runApp(const SongTinderApp());
}

class SongTinderApp extends StatefulWidget {
  const SongTinderApp({Key? key}) : super(key: key);

  @override
  State<SongTinderApp> createState() => _SongTinderAppState();

  static _SongTinderAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_SongTinderAppState>()!;
}

class _SongTinderAppState extends State<SongTinderApp> {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode getTheme() => _themeMode;
  void changeTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Song Tinder',
        themeMode: _themeMode,
        theme: ThemeData(
          shadowColor: Colors.black.withAlpha(60),
          colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Color.fromARGB(255, 255, 255, 255),
              onPrimary: Color.fromARGB(255, 36, 36, 36),
              secondary: Color.fromARGB(255, 241, 9, 9),
              onSecondary: Color.fromARGB(255, 255, 255, 255),
              error: Colors.red,
              onError: Colors.white,
              background: Colors.green,
              onBackground: Colors.white,
              surface: Colors.black,
              onSurface: Colors.white,
              shadow: Color.fromARGB(128, 0, 0, 0)),
          textTheme: TextTheme(
            headlineLarge: GoogleFonts.roboto(
              fontSize: 35,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: const Color.fromARGB(255, 36, 36, 36),
            ),
            displayMedium: GoogleFonts.roboto(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
            displaySmall: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
          ),
        ),
        darkTheme: ThemeData(
          shadowColor: Colors.black.withAlpha(60),
          colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: Color.fromARGB(255, 36, 36, 36),
              onPrimary: Color.fromARGB(255, 255, 255, 255),
              secondary: Color.fromARGB(255, 255, 255, 255),
              onSecondary: Color.fromARGB(255, 241, 9, 9),
              error: Colors.red,
              onError: Colors.white,
              background: Colors.green,
              onBackground: Colors.white,
              surface: Colors.black,
              onSurface: Colors.white,
              shadow: Color.fromARGB(128, 0, 0, 0)),
          textTheme: TextTheme(
            headlineLarge: GoogleFonts.roboto(
              fontSize: 35,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            displayMedium: GoogleFonts.roboto(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
            displaySmall: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
          ),
        ),
        home: const AppBody());
  }
}

class AppBody extends StatelessWidget {
  const AppBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Stack(alignment: Alignment.center, children: [
                Icon(
                  Icons.favorite,
                  size: MediaQuery.of(context).size.width / 6,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                Transform.rotate(
                  angle: 0.1,
                  child: Icon(
                    Icons.music_note_sharp,
                    size: MediaQuery.of(context).size.width / 12,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ]),
              actions: const <Widget>[ThemeButton(), SettingsButton()],
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            bottomNavigationBar: BottomAppBar(
                color: Theme.of(context).colorScheme.primary,
                child: TabBar(
                  indicatorColor: Theme.of(context).colorScheme.onPrimary,
                  indicatorWeight: 4.0,
                  tabs: [
                    Tab(
                        icon: Icon(
                      Icons.home,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
                    Tab(
                        icon: Icon(
                      Icons.settings_applications,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ))
                  ],
                )),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [const HomePageWidget(), ConfPageWidget()],
            )));
  }
}
