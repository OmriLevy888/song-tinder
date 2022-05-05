import 'package:flutter/material.dart';
import 'package:song_tinder/main.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.brightness_medium),
      onPressed: () {
        switch (SongTinderApp.of(context).getTheme()) {
          case ThemeMode.dark:
            SongTinderApp.of(context).changeTheme(ThemeMode.light);
            break;
          case ThemeMode.light:
            SongTinderApp.of(context).changeTheme(ThemeMode.system);
            break;
          case ThemeMode.system:
            SongTinderApp.of(context).changeTheme(ThemeMode.dark);
            break;
        }
      },
    );
  }
}
