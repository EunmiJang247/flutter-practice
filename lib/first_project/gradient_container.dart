import 'package:first_app/first_project/dice_roller.dart';
import 'package:flutter/material.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomCenter;

class FirstProject extends StatelessWidget {
  const FirstProject({super.key, required this.colors});

  final List<Color> colors;
  @override
  Widget build(context) {
    return MaterialApp(
        home: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: colors, begin: startAlignment, end: endAlignment)),
      child: Center(child: DiceRoller()),
    ));
  }
}
