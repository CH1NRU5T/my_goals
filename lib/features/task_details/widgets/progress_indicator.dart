import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  const CustomCircularProgressIndicator(
      {super.key, required this.current, required this.max});
  final double current;
  final double max;

  @override
  State<CustomCircularProgressIndicator> createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: widget.current / widget.max),
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
                '\$${(value * widget.max).round()}\nYou saved',
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
    // return SimpleCircularProgressBar(
    //   maxValue: widget.max,
    //   animationDuration: 4,
    //   valueNotifier: ValueNotifier<double>(widget.current),
    //   size: 150,
    //   onGetText: (value) {
    //     return Text(
    //       '\$${value.round()}\nYou saved',
    //       textAlign: TextAlign.center,
    //       style: const TextStyle(
    //         fontSize: 16,
    //         fontWeight: FontWeight.bold,
    //         color: Colors.white,
    //       ),
    //     );
    //   },
    // );
  }
}
