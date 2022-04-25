import 'package:flutter/material.dart';
import 'package:song_tinder/widgets/widgets.dart';

class HomePageSwipeButtons extends StatelessWidget {
  const HomePageSwipeButtons({
    Key? key,
    required this.nopeButtonAction,
    required this.likeButtonAction,
    required this.superLikeButtonAction,
  }) : super(key: key);

  final void Function()? nopeButtonAction;
  final void Function()? likeButtonAction;
  final void Function()? superLikeButtonAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 60.0, right: 60.0, bottom: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleButton(
            radius: 30,
            color: const Color.fromARGB(255, 221, 0, 0),
            icon: Icons.close,
            onPressed: nopeButtonAction,
            onLongPress: () => print('Configure swipe left'),
          ),
          CircleButton(
            radius: 25,
            color: const Color.fromARGB(255, 0, 181, 226),
            icon: Icons.menu,
            onPressed: superLikeButtonAction,
            onLongPress: () => print('Configure swipe up'),
          ),
          CircleButton(
            radius: 30,
            color: const Color.fromARGB(255, 1, 202, 62),
            icon: Icons.favorite,
            onPressed: likeButtonAction,
            onLongPress: () => print('Configure swipe right'),
          ),
        ],
      ),
    );
  }
}
