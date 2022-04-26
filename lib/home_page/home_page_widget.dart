import 'package:flutter/material.dart';
import 'package:song_tinder/home_page/song_provider.dart';
import 'package:song_tinder/widgets/widgets.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key? key, required this.songProvider}) : super(key: key);

  late SongProvider songProvider;

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageSwipeCards _swipeCards;

  @override
  void initState() {
    _swipeCards = HomePageSwipeCards(songProvider: widget.songProvider);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      _swipeCards,
      HomePageSwipeButtons(
        likeButtonAction: () => _swipeCards.matchEngine.currentItem?.like(),
        nopeButtonAction: () => _swipeCards.matchEngine.currentItem?.nope(),
        superLikeButtonAction: () =>
            _swipeCards.matchEngine.currentItem?.superLike(),
      )
    ]);
  }
}
