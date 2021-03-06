import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton(
      {Key? key,
      required this.onPressed,
      this.onLongPress,
      required this.radius,
      this.backgroundColor,
      required this.color,
      required this.icon,
      this.iconSize})
      : super(key: key);

  final void Function()? onPressed;
  final void Function()? onLongPress;

  final double radius;
  final Color? backgroundColor;
  final Color color;
  final IconData icon;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: radius * 2,
        width: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 4,
              blurRadius: 8,
              offset: const Offset(6, 3),
            ),
          ],
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Icon(
            icon,
            color: color,
            size: iconSize?? radius * 1.1,
          ),
          onLongPress: onLongPress,
        ));
  }
}
