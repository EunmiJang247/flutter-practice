import 'dart:math';

import 'package:flutter/material.dart';
import 'package:first_app/first_project/styled_text.dart';

final randomizer = Random();

// StatefulWidget에서 createState(){} 를 친다.

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  // super.key는 부모 클래스(StatelessWidget)에 key 값을 전달하는 역할
  // key는 Flutter가 위젯 트리에서 동일한 위젯인지 식별하는 데 사용돼

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 2;

  void rollDice() {
    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1;
    });
    // 이렇게 UI가 변한다면 StatelessWidget -> StatefulWidget으로 변경해야함
    // 그래서 StatefulWidget을 하나 만들었다
  }

  @override
  Widget build(context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/dice-$currentDiceRoll.png',
            width: 200,
          ),
          SizedBox(height: 20,),
          TextButton(
            onPressed: rollDice,
            style: TextButton.styleFrom(
                // padding: EdgeInsets.all(24),
                padding: EdgeInsets.only(top:24),
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 28)),
            child: const Text('Roll Dice'),
          )
        ],
      );
  }
}