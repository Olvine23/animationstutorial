import 'package:flutter/material.dart';

class TestAnimation extends StatelessWidget {
  const TestAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        height: 100,
        width: 300 / 3,
        duration: Duration(seconds: 3),
        color: Colors.red,
      ),
    );
  }
}
