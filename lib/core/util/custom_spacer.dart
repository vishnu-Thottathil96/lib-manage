import 'package:flutter/material.dart';

class SpaceWidget extends StatelessWidget {
  final double size;
  final Axis axis;

  const SpaceWidget({super.key, required this.size, this.axis = Axis.vertical});

  @override
  Widget build(BuildContext context) {
    return axis == Axis.vertical
        ? SizedBox(height: size)
        : SizedBox(width: size);
  }
}
