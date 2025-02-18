import 'dart:math';

import 'package:flutter/material.dart';

final randomizer = Random();

// StatefulWidget에서 createState(){} 를 친다.

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  // super.key는 부모 클래스(StatelessWidget)에 key 값을 전달하는 역할
  // key는 Flutter가 위젯 트리에서 동일한 위젯인지 식별하는 데 사용돼

  @override
  State<DiceRoller> createState() {
    // StatefulWidget을 만들 때 반드시 createState() 메서드를 오버라이드 해야함
    // 이 메서드는 위젯의 상태를 관리할 State 객체를 반환
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
    // setState가 실행되면 아래 build가 한번 더 실행된다
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