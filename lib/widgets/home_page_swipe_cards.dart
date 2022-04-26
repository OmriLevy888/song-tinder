import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:song_tinder/home_page/song_provider.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:song_tinder/models/models.dart';
import 'package:song_tinder/widgets/widgets.dart';

class HomePageSwipeCards extends StatefulWidget {
  HomePageSwipeCards({Key? key, required this.songProvider}) : super(key: key);

  late MatchEngine matchEngine;
  late SongProvider songProvider;

  @override
  State<HomePageSwipeCards> createState() => _HomePageSwipeCardsState();
}

class _HomePageSwipeCardsState extends State<HomePageSwipeCards> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  final Queue<SongModel> _songQueue = Queue();

  @override
  void initState() {
    // Fetch a few songs so we preload the SongModel in the back of the current one
    for (int i = 0; i < 8; i++) {
      _addSongToStack(widget.songProvider.poll());
    }
    widget.matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  void _addSongToStack(SongModel song) {
    _songQueue.add(song);
    _swipeItems.add(_buildSwipeItem(song));
    print(
        'Adding song ${song.name} to stack, queue size is ${_songQueue.length}');
  }

  SwipeItem _buildSwipeItem(SongModel song) {
    return SwipeItem(
      content: song,
      likeAction: () => _onSwipeRight(song),
      nopeAction: () => _onSwipeLeft(song),
      superlikeAction: () => _onSwipeUp(song),
      onSlideUpdate: (SlideRegion? region) async {},
    );
  }

  void _onSwipeRight(SongModel song) {
    print('Swiped right on ${song.name} by ${song.artist}');
  }

  void _onSwipeLeft(SongModel song) {
    print('Swiped left on ${song.name} by ${song.artist}');
  }

  void _onSwipeUp(SongModel song) {
    print('Swiped up on ${song.name} by ${song.artist}');
  }

  @override
  Widget build(BuildContext context) {
    return SwipeCards(
      matchEngine: widget.matchEngine,
      upSwipeAllowed: true,
      itemBuilder: (BuildContext context, int index) {
        return SongCardWidget(songData: _songQueue.first);
      },
      onStackFinished: () => print('Finished entire stack'),
      itemChanged: (SwipeItem item, int index) {
        _songQueue.removeFirst();
        _addSongToStack(widget.songProvider.poll());
      },
    );
  }
}
