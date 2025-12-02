import 'package:flutter/material.dart';

class AnimatedCollapsible extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool isExpanded;
  final double? maxHeight;
  final Curve curve;

  const AnimatedCollapsible({
    super.key,
    required this.child,
    this.isExpanded = false,
    this.maxHeight,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.fastOutSlowIn,
  });

  @override
  State<AnimatedCollapsible> createState() => _AnimatedCollapsibleState();
}

class _AnimatedCollapsibleState extends State<AnimatedCollapsible> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration, value: widget.isExpanded ? 1.0 : 0.0);

    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void didUpdateWidget(covariant AnimatedCollapsible oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }

    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = widget.child;

    if (widget.maxHeight != null) {
      content = ConstrainedBox(
        constraints: BoxConstraints(maxHeight: widget.maxHeight!),
        child: SingleChildScrollView(physics: const ClampingScrollPhysics(), child: content),
      );
    }

    return SizeTransition(sizeFactor: _animation, axisAlignment: -1.0, child: content);
  }
}
