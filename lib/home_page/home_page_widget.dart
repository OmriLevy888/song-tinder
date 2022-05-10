import 'package:flutter/material.dart';
import 'package:song_tinder/home_page/song_cards/song_cards.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SongSwipeCards();
  }
}