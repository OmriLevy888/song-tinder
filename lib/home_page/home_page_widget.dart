import 'package:flutter/material.dart';
import 'package:song_tinder/providers/song_provider.dart';
import 'package:song_tinder/widgets/widgets.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageSwipeCards _swipeCards;

  @override
  void initState() {
    _swipeCards = HomePageSwipeCards();

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
