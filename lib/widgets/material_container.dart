import 'package:flutter/material.dart';

import 'material_inkwell.dart';

class MaterialContainer extends StatelessWidget {
  const MaterialContainer({
    super.key,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.margin,
    this.child,
    this.borderRadius,
    this.onTap,
    this.clipBehavior = Clip.none,
  });

  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final Decoration? foregroundDecoration;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius; // Accept explicit border radius if needed
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final effectiveDecoration = decoration ?? (color != null ? BoxDecoration(color: color) : null);

    BorderRadius? effectiveBorderRadius = borderRadius;
    if (effectiveBorderRadius == null && effectiveDecoration is BoxDecoration) {
      final geometry = effectiveDecoration.borderRadius;
      if (geometry is BorderRadius) {
        effectiveBorderRadius = geometry;
      }
    }

    return Container(
      margin: margin,
      decoration: effectiveDecoration,
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      transform: transform,
      transformAlignment: transformAlignment,
      clipBehavior: clipBehavior,
      alignment: alignment,
      color: color,
      child: child != null
          ? MaterialInkWell(padding: padding, borderRadius: effectiveBorderRadius, onTap: onTap, child: child!)
          : null,
    );
  }
}
