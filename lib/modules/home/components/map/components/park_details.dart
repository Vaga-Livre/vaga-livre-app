import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

import '../../../../../utils/formatters.dart';
import '../../../controllers/parks_search_controller.dart';

class ParkDetails extends StatelessWidget {
  const ParkDetails({
    required this.park,
    super.key,
  });

  final ParkResult park;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foregroundColor = theme.colorScheme.onPrimary;
    final backgroundColor = theme.colorScheme.primary;

    return DefaultTextStyle(
      style: TextStyle(color: foregroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: ShapeDecoration(
              color: backgroundColor,
              shadows: kElevationToShadow[2],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  park.label,
                  style: theme.textTheme.titleMedium?.copyWith(color: foregroundColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Valor: ${currencyFormatter.format(park.price)}",
                      style: theme.textTheme.labelMedium?.copyWith(color: foregroundColor),
                    ),
                    Text(switch (park.slotsCount) { 1 => "1 espaço", _ => "${park.slotsCount} espaços" })
                  ],
                ),
                const Divider(height: 4),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Toque para ver detalhes.",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: foregroundColor),
                  ),
                )
              ],
            ),
          ),
          ClipRect(
            child: SizedBox(
              width: 30,
              height: 30,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..translate(Vector3(0, -25, 0))
                  ..rotateZ(pi / 4),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(color: backgroundColor, boxShadow: kElevationToShadow[2]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter({this.strokeColor = Colors.black, this.strokeWidth = 3, this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(x, 0)
      ..lineTo(x / 2, y)
      ..lineTo(0, 0);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
