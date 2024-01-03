import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator(
      {super.key, required this.current, required this.max});
  final double current;
  final double max;
  @override
  Widget build(BuildContext context) {
    // return TweenAnimationBuilder<double>(
    //   tween: Tween(begin: 0.0, end: current),
    //   duration: const Duration(seconds: 1),
    //   builder: (context, value, child) {
    //     return CircularProgressIndicator.adaptive(
    //       strokeWidth: 10,
    //       strokeAlign: CircularProgressIndicator.strokeAlignCenter,
    //       semanticsLabel: 'Progress',
    //       strokeCap: StrokeCap.round,
    //       backgroundColor: Colors.grey[300],
    //       semanticsValue: '${(value * 100).round()}%',
    //       value: value,
    //     );

    //   },
    // );
    return SimpleCircularProgressBar(
      maxValue: max,
      animationDuration: 4,
      valueNotifier: ValueNotifier<double>(current),
      size: 150,
      onGetText: (value) {
        return Text(
          '\$${value.round()}\nYou saved',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
