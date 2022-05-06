import 'package:flutter/material.dart';
import 'package:song_tinder/widgets/widgets.dart';

class HomePageSwipeButtons extends StatelessWidget {
  const HomePageSwipeButtons({
    Key? key,
    required this.swipeLeftButtonAction,
    required this.swipeRightButtonAction,
    required this.swipeUpButtonAction,
  }) : super(key: key);

  final void Function()? swipeLeftButtonAction;
  final void Function()? swipeRightButtonAction;
  final void Function()? swipeUpButtonAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 5,
          right: MediaQuery.of(context).size.width / 5,
          bottom: MediaQuery.of(context).size.width / 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleButton(
            radius: 30,
            color: const Color.fromARGB(255, 221, 0, 0),
            icon: Icons.close,
            onPressed: swipeLeftButtonAction,
          ),
          CircleButton(
            radius: 25,
            color: const Color.fromARGB(255, 0, 181, 226),
            icon: Icons.menu,
            onPressed: swipeUpButtonAction,
            onLongPress: () => print('Configure swipe up'),
          ),
          CircleButton(
            radius: 30,
            color: const Color.fromARGB(255, 1, 202, 62),
            icon: Icons.favorite,
            onPressed: swipeRightButtonAction,
            onLongPress: () => print('Configure swipe right'),
          ),
        ],
      ),
    );
  }
}
