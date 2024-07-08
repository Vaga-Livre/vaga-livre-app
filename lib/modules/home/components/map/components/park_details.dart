import 'package:flutter/material.dart';
import 'package:vagalivre/modules/home/controllers/parks_search_controller.dart';

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
        children: [
          Expanded(
            child: Container(
              color: backgroundColor,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    park.label,
                    style: theme.textTheme.titleMedium?.copyWith(color: foregroundColor),
                  ),
                  Text("Algumas informações importantes"),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 24,
            height: 10,
            child: CustomPaint(
              painter: TrianglePainter(
                strokeColor: backgroundColor,
                paintingStyle: PaintingStyle.fill,
                strokeWidth: 4,
              ),
            ),
          ),
          const SizedBox.square(dimension: 52),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

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
