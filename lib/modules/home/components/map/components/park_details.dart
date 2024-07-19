import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

import '../../../../../utils/formatters.dart';
import '../../../models/park_result.dart';

class ParkDetailsAnimatedMarker extends AnimatedMarker {
  ParkDetailsAnimatedMarker(ParkResult selectedPark)
      : super(
          key: Key(selectedPark.label),
          point: selectedPark.location,
          width: 250,
          height: 250,
          alignment: Alignment.topCenter,
          builder: (context, animation) {
            return ScaleTransition(
              scale: animation,
              alignment: const Alignment(0, 0.5),
              child: ParkDetails(park: selectedPark),
            );
          },
        );
}

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

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Card(
          color: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
          margin: const EdgeInsets.all(0),
          child: InkWell(
            onTap: () => context.push("/park", extra: park),
            child: DefaultTextStyle(
              style: TextStyle(color: foregroundColor),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      park.label,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: foregroundColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Valor: ${currencyFormatter.format(park.price)}",
                          style: theme.textTheme.labelMedium
                              ?.copyWith(color: foregroundColor),
                        ),
                        Text(switch (park.slotsCount) {
                          1 => "1 espaço",
                          _ => "${park.slotsCount} espaços"
                        })
                      ],
                    ),
                    const Divider(height: 4),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Toque para ver detalhes.",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: foregroundColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
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
                decoration: BoxDecoration(
                    color: backgroundColor, boxShadow: kElevationToShadow[2]),
              ),
            ),
          ),
        ),
      ],
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
