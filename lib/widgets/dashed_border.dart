import 'dart:math' as math;

import 'package:flutter/material.dart';

class DashedBorder extends StatelessWidget {
  const DashedBorder({
    super.key,
    this.strokeWidth = 2,
    this.dashLength = 6,
    this.dashSpace = 3,
    this.color = const Color(0xFFCBCBCB),
    this.gradient,
    this.radius = BorderRadius.zero,
    required this.child,
  });

  final double strokeWidth;
  final double dashLength;
  final double dashSpace;
  final Color color;
  final Gradient? gradient;
  final BorderRadius radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashBorderPainter(
        strokeWidth: strokeWidth,
        dashLength: dashLength,
        dashSpace: dashSpace,
        color: color,
        gradient: gradient,
        radius: radius,
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: child,
      ),
    );
  }
}

class DashBorderPainter extends CustomPainter {
  final double strokeWidth;
  final double dashLength;
  final double dashSpace;
  final Color color;
  final Gradient? gradient;
  final BorderRadius radius;

  DashBorderPainter({
    this.strokeWidth = 5.0,
    this.dashLength = 5.0,
    this.dashSpace = 5.0,
    this.color = Colors.red,
    this.gradient,
    this.radius = BorderRadius.zero,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..shader = gradient?.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..style = PaintingStyle.stroke;

    final topLeftX = radius.topLeft.x;
    final topRightX = radius.topRight.x;
    final bottomRightX = radius.bottomRight.x;
    final bottomLeftX = radius.bottomLeft.x;
    final topLeftY = radius.topLeft.y;
    final topRightY = radius.topRight.y;
    final bottomRightY = radius.bottomRight.y;
    final bottomLeftY = radius.bottomLeft.y;

    double startX = topLeftX;
    // Top side
    while (startX < size.width - topRightX) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(_calculateMaxWidth(startX, size.width - topRightX), 0),
        paint,
      );
      startX += dashLength + dashSpace;
    }

    canvas.drawDashedArc(
      Rect.fromCircle(
        center: Offset(size.width - topRightX, topRightY),
        radius: topRightX,
      ),
      3 * math.pi / 2,
      math.pi / 2,
      dashLength,
      dashSpace,
      paint,
    );

    // Right side
    double startY = topRightY;
    while (startY < size.height - bottomRightY) {
      canvas.drawLine(
        Offset(size.width, startY),
        Offset(
          size.width,
          _calculateMaxHeight(
            startY,
            size.height - bottomRightY,
          ),
        ),
        paint,
      );
      startY += dashLength + dashSpace;
    }

    canvas.drawDashedArc(
      Rect.fromCircle(
        center: Offset(size.width - bottomRightX, size.height - bottomRightY),
        radius: bottomRightX,
      ),
      0,
      math.pi / 2,
      dashLength,
      dashSpace,
      paint,
    );

    // Bottom side
    startX = size.width - bottomRightX;
    while (startX > bottomLeftX) {
      canvas.drawLine(
        Offset(startX, size.height),
        Offset(
          _calculateMinWidth(startX),
          size.height,
        ),
        paint,
      );
      startX -= dashLength + dashSpace;
    }

    canvas.drawDashedArc(
      Rect.fromCircle(
        center: Offset(bottomLeftX, size.height - bottomLeftY),
        radius: bottomLeftX,
      ),
      math.pi / 2,
      math.pi / 2,
      dashLength - 1,
      dashSpace,
      paint,
    );

    // Left side
    startY = size.height - bottomLeftY;
    while (startY > topLeftY) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(
          0,
          _calculateMinHeight(startY),
        ),
        paint,
      );
      startY -= dashLength + dashSpace;
    }

    canvas.drawDashedArc(
      Rect.fromCircle(
        center: Offset(topLeftX, topLeftY),
        radius: topLeftX,
      ),
      math.pi,
      math.pi / 2,
      dashLength - 1,
      dashSpace,
      paint,
    );
  }

  double _calculateMaxWidth(double startX, double width) {
    return startX + dashLength > width ? width : startX + dashLength;
  }

  double _calculateMaxHeight(double startY, double height) {
    return startY + dashLength > height ? height : startY + dashLength;
  }

  double _calculateMinWidth(double startX) {
    return startX - dashLength < 0 ? 0 : startX - dashLength;
  }

  double _calculateMinHeight(double startY) {
    return startY - dashLength < 0 ? 0 : startY - dashLength;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

extension CanvasExtension on Canvas {
  void drawDashedLine(
    Offset p1,
    Offset p2,
    double dashLength,
    double dashSpace,
    Paint paint,
  ) {
    final distance = p1.distanceTo(p2);
    final dx = (p2.dx - p1.dx) / distance;
    final dy = (p2.dy - p1.dy) / distance;
    var dashRemaining = dashLength;
    var spaceRemaining = dashSpace;

    var current = p1;
    while (current.distanceTo(p2) >= dashLength) {
      if (dashRemaining > 0) {
        final next = current + Offset(dx * dashRemaining, dy * dashRemaining);
        drawLine(current, next, paint);
        current = next;
        dashRemaining = 0;
      } else {
        final next = current + Offset(dx * spaceRemaining, dy * spaceRemaining);
        current = next;
        spaceRemaining = dashSpace;
      }
    }

    drawLine(current, p2, paint);
  }

  void drawDashedRect(
    Rect rect,
    double dashLength,
    double dashSpace,
    Paint paint,
  ) {
    drawDashedLine(rect.topLeft, rect.topRight, dashLength, dashSpace, paint);
    drawDashedLine(
        rect.topRight, rect.bottomRight, dashLength, dashSpace, paint);
    drawDashedLine(
        rect.bottomRight, rect.bottomLeft, dashLength, dashSpace, paint);
    drawDashedLine(rect.bottomLeft, rect.topLeft, dashLength, dashSpace, paint);
  }

  void drawDashedCircle(
    Offset center,
    double radius,
    double dashLength,
    double dashSpace,
    Paint paint,
  ) {
    final circumference = 2 * math.pi * radius;
    final dashCount = (circumference / (dashLength + dashSpace)).floor();
    final angle = 2 * math.pi / dashCount;

    var current = center + Offset(radius, 0);
    for (var i = 0; i < dashCount; i++) {
      final next = center +
          Offset(
            radius * math.cos(angle * (i + 1)),
            radius * math.sin(angle * (i + 1)),
          );
      drawLine(current, next, paint);
      current = next;
    }
  }

  void drawDashedArc(
    Rect rect,
    double startAngle,
    double sweepAngle,
    double dashLength,
    double dashSpace,
    Paint paint,
  ) {
    final path = Path();
    final radius = rect.width / 2;
    final center = rect.center;

    final totalLength = sweepAngle * radius;

    var dashCount = (totalLength / (dashLength + dashSpace)).floor();
    dashCount = math.max(dashCount, 2);
    final anglePerDash = sweepAngle / dashCount;

    for (var i = 0; i < dashCount; i++) {
      final startAngleDash = startAngle + i * anglePerDash;

      path.moveTo(
        center.dx + radius * math.cos(startAngleDash),
        center.dy + radius * math.sin(startAngleDash),
      );

      path.arcTo(
        rect,
        startAngleDash,
        dashLength / radius,
        false,
      );
    }

    drawPath(path, paint);
  }
}

extension OffsetExtension on Offset {
  Offset operator +(Offset other) {
    return Offset(dx + other.dx, dy + other.dy);
  }

  Offset operator -(Offset other) {
    return Offset(dx - other.dx, dy - other.dy);
  }

  Offset operator *(double scalar) {
    return Offset(dx * scalar, dy * scalar);
  }

  Offset operator /(double scalar) {
    return Offset(dx / scalar, dy / scalar);
  }

  double distanceTo(Offset other) {
    return (dx - other.dx).abs() + (dy - other.dy).abs();
  }
}
