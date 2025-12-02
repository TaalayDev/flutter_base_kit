import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    super.key,
    this.child,
    this.enabled = true,
    this.width,
    this.height,
    this.radius,
  });

  final Widget? child;
  final bool enabled;
  final double? width;
  final double? height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    Widget widget = child ??
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius:
                radius != null ? BorderRadius.circular(radius!) : null,
          ),
        );

    if (enabled) {
      widget = Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.5),
        highlightColor: Colors.white,
        child: widget,
      );
    }

    return widget;
  }
}
