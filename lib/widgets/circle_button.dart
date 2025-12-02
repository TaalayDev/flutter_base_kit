import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;

  const CircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.padding = const EdgeInsets.all(12.0),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(padding: padding, child: icon),
      ),
    );
  }
}
