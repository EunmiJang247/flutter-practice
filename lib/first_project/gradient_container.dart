// 위젯은 각각의 다른 파일로 구분해주는 것이 좋다.
import 'package:first_app/first_project/dice_roller.dart';
import 'package:first_app/first_project/styled_text.dart';
import 'package:flutter/material.dart';

// dart의 변수 지정방법
const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomCenter; // final: 새로운값을 받지 않겠다

class FirstProject extends StatelessWidget {
  const FirstProject({super.key, required this.colors});
  // {key}는 매개변수로 들어가는 우리가 넣어준 키
  // super를 통해 부모class에 접근
  // super.key를 통해 부모 class에 우리의 key를 전달해준다

  final List<Color> colors;

  // StatelessWidget: 플러터에서 제공하는 클래스를 상속
  @override // build라는 메서드를 우리가 직접 만든다는 것을 선언하는 것
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: colors, begin: startAlignment, end: endAlignment)),
      child: Center(
          child: DiceRoller() ),
    );
  }
  // StatelessWidget를 상속받음으로써 build라는 메서드를 추가해야만 한다
  // Widget을 반환하니까 Widget을 맨앞에 추가했음. build는 함수인것이다.
  // void가 아닌 Widget를 반환하니까 return으로 그것을 반환해주어야 한다
  // context 라는 매개변수를 넣어줘야 한다.
}
