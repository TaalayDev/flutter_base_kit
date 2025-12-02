import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  final String icon;
  final double? size;
  final Color? color;
  final bool originalColor;

  const AppIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.originalColor = false, // const Color(0xff636363),
  });

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? IconTheme.of(context).size ?? 24.0;
    Widget image;
    if (icon.endsWith('.svg')) {
      image = SvgPicture.asset(
        icon,
        height: size,
        width: size,
        colorFilter: originalColor
            ? null
            : ColorFilter.mode(
                color ?? IconTheme.of(context).color ?? Colors.black,
                BlendMode.srcIn,
              ),
      );
    } else {
      image = Image.asset(
        icon,
        height: size,
        width: size,
        color: originalColor ? null : color ?? IconTheme.of(context).color,
      );
    }

    return SizedBox(
      height: size,
      width: size,
      child: Center(child: image),
    );
  }
}
