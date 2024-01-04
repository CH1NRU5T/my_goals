import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator(
      {super.key, required this.current, required this.max});
  final double current;
  final double max;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: current / max),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: CircularProgressIndicator(
                strokeWidth: 10,
                strokeAlign: CircularProgressIndicator.strokeAlignCenter,
                semanticsLabel: 'Progress',
                strokeCap: StrokeCap.round,
                backgroundColor: Colors.grey[300],
                semanticsValue: '${(value * 100).round()}%',
                value: value,
              ),
            ),
            Center(
              child: Text(
                '\$${(value * max).round()}\nYou saved',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
