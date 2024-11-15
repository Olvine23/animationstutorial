import 'package:flutter/material.dart';
import 'package:myapp/animated_container.dart';
import 'package:myapp/cat_screen.dart';
import 'package:myapp/test_animation.dart';
import 'package:myapp/tween_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  CatApp());
  }
}
