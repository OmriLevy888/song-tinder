import 'package:flutter/material.dart';
import 'package:song_tinder/widgets/widgets.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final HomePageSwipeCards _swipeCards = HomePageSwipeCards();

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
