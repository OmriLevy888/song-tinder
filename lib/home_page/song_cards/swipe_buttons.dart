import 'package:flutter/material.dart';
import 'package:song_tinder/widgets/widgets.dart';

import 'dart:math' as math;

class SwipeButtons extends StatelessWidget {
  const SwipeButtons({
    Key? key,
    required this.dragState,
    required this.swipeLeftButtonAction,
    required this.swipeRightButtonAction,
    required this.swipeUpButtonAction,
    required this.enabled,
  }) : super(key: key);

  final DragState dragState;
  final void Function()? swipeLeftButtonAction;
  final void Function()? swipeRightButtonAction;
  final void Function()? swipeUpButtonAction;
  final bool enabled;

  Color _getButtonBackgroundColor(BuildContext context, Color baseColor,
      Color accentColor, double mixFactor) {
    if (!enabled) {
      return Theme.of(context).disabledColor;
    }

    int mixChannel(int base, int accent) =>
        (base + mixFactor * (accent - base)).toInt();

    return Color.fromARGB(
        mixChannel(baseColor.alpha, accentColor.alpha),
        mixChannel(baseColor.red, accentColor.red),
        mixChannel(baseColor.green, accentColor.green),
        mixChannel(baseColor.blue, accentColor.blue));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "dragState: (${dragState.left()}, ${dragState.up()}, ${dragState.right()})");
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
            backgroundColor: _getButtonBackgroundColor(
                context,
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.onPrimary,
                dragState.left()),
            color: const Color.fromARGB(255, 221, 0, 0),
            icon: Icons.close,
            onPressed: swipeLeftButtonAction,
          ),
          CircleButton(
            radius: MediaQuery.of(context).size.width / 12.5,
            backgroundColor: _getButtonBackgroundColor(
                context,
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.onPrimary,
                dragState.up()),
            color: const Color.fromARGB(255, 0, 181, 226),
            icon: Icons.menu,
            onPressed: swipeUpButtonAction,
            onLongPress: () => debugPrint('Configure swipe up'),
          ),
          CircleButton(
            radius: MediaQuery.of(context).size.width / 10,
            backgroundColor: _getButtonBackgroundColor(
                context,
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.onPrimary,
                dragState.right()),
            color: const Color.fromARGB(255, 1, 202, 62),
            icon: Icons.favorite,
            onPressed: swipeRightButtonAction,
            onLongPress: () => debugPrint('Configure swipe right'),
          ),
        ],
      ),
    );
  }
}

class DragState {
  double _horizontal = 0.0;
  double _vertical = 0.0;

  DragState();

  void onDragUpdate(DragUpdateDetails drag) {
    _horizontal += drag.delta.dx;
    _vertical += drag.delta.dy;
    debugPrint("left: ${left()}, up: ${up()}, right: ${right()}");
  }

  double _retWrapper(double value) {
    return value.isNaN
        ? 0.0
        : value.isInfinite
            ? 0.0
            : math.max(math.min(value - 0.25, 1.0), 0.0);
  }

  double left() {
    return _retWrapper(
        (_horizontal < 0) ? math.log(_horizontal.abs()) / math.log(300) : 0.0);
  }

  double up() {
    return _retWrapper(
        (_vertical < 0) ? math.log(_horizontal.abs()) / math.log(30) : 0.0);
  }

  double right() {
    return _retWrapper(
        (_horizontal > 0) ? math.log(_horizontal.abs()) / math.log(300) : 0.0);
  }
}
