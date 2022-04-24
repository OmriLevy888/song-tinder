import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:song_tinder/home_page/dummy_music_service.dart';
import 'package:song_tinder/home_page/song_provider.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:song_tinder/models/models.dart';
import 'package:song_tinder/widgets/widgets.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late MatchEngine _matchEngine;
  final _swipeItems = <SwipeItem>[];
  final Queue<SongModel> _songQueue = Queue();
  // The SongProviderConfig should be updated from the value in the config page
  final _songProvider = SongProvider(
    config: SongProviderConfig(source: 'TODO'),
    musicService: DummyMusicService(),
  );

  @override
  void initState() {
    // Fetch a few songs so we preload the SongModel in the back of the current one
    for (int i = 0; i < 8; i++) {
      _addSongToStack(_songProvider.poll());
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
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
    return Stack(alignment: Alignment.bottomCenter, children: [
      SwipeCards(
        matchEngine: _matchEngine,
        upSwipeAllowed: true,
        itemBuilder: (BuildContext context, int index) {
          return SongCardWidget(songData: _songQueue.first);
        },
        onStackFinished: () => print('Finished entire stack'),
        itemChanged: (SwipeItem item, int index) {
          _songQueue.removeFirst();
          _addSongToStack(_songProvider.poll());
        },
      ),
      Container(
        padding: const EdgeInsets.only(left: 60.0, right: 60.0, bottom: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleButton(
              radius: 30,
              color: const Color.fromARGB(255, 221, 0, 0),
              icon: Icons.close,
              onPressed: () {
                _matchEngine.currentItem?.nope();
                _onSwipeLeft(_songQueue.first);
              },
            ),
            CircleButton(
              radius: 25,
              color: const Color.fromARGB(255, 0, 181, 226),
              icon: Icons.menu,
              onPressed: () {
                _matchEngine.currentItem?.superLike();
                _onSwipeUp(_songQueue.first);
              },
              onLongPress: () => print('Configure swipe up'),
            ),
            CircleButton(
              radius: 30,
              color: const Color.fromARGB(255, 1, 202, 62),
              icon: Icons.favorite,
              onPressed: () {
                _matchEngine.currentItem?.like();
                _onSwipeRight(_songQueue.first);
              },
              onLongPress: () => print('Configure swipe right'),
            ),
          ],
        ),
      ),
    ]);
  }
}
