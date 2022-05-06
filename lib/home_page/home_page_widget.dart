import 'package:flutter/material.dart';
import 'package:song_tinder/home_page/song_cards/song_card.dart';
import 'package:song_tinder/home_page/song_cards/song_cards.dart';
import 'package:song_tinder/home_page/song_provider.dart';
import 'package:song_tinder/widgets/widgets.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SongSwipeCards();
  }
}