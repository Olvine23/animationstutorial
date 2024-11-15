import 'dart:ui';
import 'package:flutter/material.dart';

class TweenAnimation extends StatefulWidget {
  const TweenAnimation({super.key});

  @override
  State<TweenAnimation> createState() => _TweenAnimationState();
}

class _TweenAnimationState extends State<TweenAnimation> {
  double _sliderValue = 0.5; // Initialize within the min and max range

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 200),
        tween: Tween<double>(begin: 0.01, end: _sliderValue),
        child: Container(
          decoration: BoxDecoration(
            // Add your decoration here...
          ),
          child: Slider(
            value: _sliderValue, // Use _sliderValue here
            min: 0.01,
            max: 1.0,
            onChanged: (value) {
              setState(() {
                _sliderValue = value.clamp(0.01, 1.0); // Clamp the value within range
              });
            },
          ),
        ),
        builder: (BuildContext context, double? value, Widget? child) {
          return ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 40 * (value ?? 0.01),
                sigmaY: 40 * (value ?? 0.01),
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
