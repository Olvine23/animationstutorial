import 'package:flutter/material.dart';

class FirstAnimation extends StatefulWidget {
  const FirstAnimation({super.key});

  @override
  State<FirstAnimation> createState() => _FirstAnimationState();
}

class _FirstAnimationState extends State<FirstAnimation> {
  double _margin = 0;
  double _width = 200.0;
  double _height = 100;
  Color _color = Colors.purple;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        margin: EdgeInsets.all(_margin),
        height: _height,
        color: _color,
        width: _width,
        duration: const Duration(milliseconds: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  {
                    setState(() {
                      _margin = 16;
                      _width = 100;
                      _height = 100;
                      _color = Colors.green;
                    });
                  }
                },
                child: Text("Click me "))
          ],
        ),
      ),
    );
  }
}
