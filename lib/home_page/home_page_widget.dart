import 'package:flutter/material.dart';
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
  final _data = songData;

  @override
  void initState() {
    print('in initState');
    for (int i = 0; i < _data.length; i++) {
      _swipeItems.add(SwipeItem(
        content: _data[i],
        likeAction: () => print('Liked ${_data[i].name}'),
        nopeAction: () => print('Noped ${_data[i].name}'),
        superlikeAction: () => print('Super Liked ${_data[i].name}'),
        onSlideUpdate: (SlideRegion? region) async {},
      ));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('in build');
    return Center(
          child: SwipeCards(
        matchEngine: _matchEngine,
        itemBuilder: (BuildContext context, int index) {
          // SongCardWidget(SongModel)
          return SongCardWidget(songData: _data[index % _data.length]);
        },
        onStackFinished: () => print('Finished entire stack'),
        itemChanged: (SwipeItem item, int index) {
          print('Changed to ${(item.content as SongModel).name}');
          _swipeItems.add(item);
        },
        upSwipeAllowed: true,
      ));
  }
}