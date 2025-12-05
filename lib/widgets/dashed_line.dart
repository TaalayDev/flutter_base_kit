import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashHeight;
  final double dashSpace;
  final bool isVertical;

  DashedLinePainter({
    this.color = Colors.grey,
    this.dashWidth = 5,
    this.dashHeight = 5,
    this.dashSpace = 3,
    this.isVertical = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double start = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = isVertical ? size.width : size.height
      ..style = PaintingStyle.stroke;

    if (isVertical) {
      while (start < size.height) {
        canvas.drawLine(
          Offset(size.width / 2, start),
          Offset(size.width / 2, start + dashHeight),
          paint,
        );
        start += dashHeight + dashSpace;
      }
    } else {
      while (start < size.width) {
        canvas.drawLine(
          Offset(start, size.height / 2),
          Offset(start + dashWidth, size.height / 2),
          paint,
        );
        start += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class DashedLine extends StatelessWidget {
  final Color color;
  final double dashWidth;
  final double dashHeight;
  final double dashSpace;
  final bool isVertical;
  final Widget? child;

  const DashedLine({
    super.key,
    this.color = Colors.grey,
    this.dashWidth = 5,
    this.dashHeight = 5,
    this.dashSpace = 3,
    this.isVertical = true,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedLinePainter(
        color: color,
        dashWidth: dashWidth,
        dashHeight: dashHeight,
        dashSpace: dashSpace,
        isVertical: isVertical,
      ),
      child: child,
    );
  }
}
