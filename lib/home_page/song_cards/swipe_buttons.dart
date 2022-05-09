import 'package:flutter/material.dart';
import 'package:song_tinder/widgets/widgets.dart';

class SwipeButtons extends StatelessWidget {
  const SwipeButtons({
    Key? key,
    required this.swipeLeftButtonAction,
    required this.swipeRightButtonAction,
    required this.swipeUpButtonAction,
    required this.enabled,
  }) : super(key: key);

  final void Function()? swipeLeftButtonAction;
  final void Function()? swipeRightButtonAction;
  final void Function()? swipeUpButtonAction;
  final bool enabled;

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
            radius: MediaQuery.of(context).size.width / 10,
            color: enabled
                ? const Color.fromARGB(255, 221, 0, 0)
                : Theme.of(context).disabledColor,
            icon: Icons.close,
            onPressed: swipeLeftButtonAction,
          ),
          CircleButton(
            radius: MediaQuery.of(context).size.width / 12.5,
            color: enabled
                ? const Color.fromARGB(255, 0, 181, 226)
                : Theme.of(context).disabledColor,
            icon: Icons.menu,
            onPressed: swipeUpButtonAction,
            onLongPress: () => debugPrint('Configure swipe up'),
          ),
          CircleButton(
            radius: MediaQuery.of(context).size.width / 10,
            color: enabled
                ? const Color.fromARGB(255, 1, 202, 62)
                : Theme.of(context).disabledColor,
            icon: Icons.favorite,
            onPressed: swipeRightButtonAction,
            onLongPress: () => debugPrint('Configure swipe right'),
          ),
        ],
      ),
    );
  }
}
