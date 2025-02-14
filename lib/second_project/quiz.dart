import 'package:first_app/second_project/questions_screen.dart';
import 'package:first_app/second_project/start_screen.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz>{
  Widget? activeScreen;
  // 위젯은 Object이기때문에 activeScreen라는 변수에 저장할수 있다
  // var로 선언하면 class가 다른 위젯을 선언할수가 없다
  // null 일수도 있기 때문에 ?를 붙인다
  // 여기 선언을 하지 않아서 ?가 붙음

  @override
  void initState() {
    // build보다 먼저 실행된다
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  // 스크린을 바꿀때 형식은 Widget으로!
  void switchScreen() {
    setState(() {
      // setState가 실행되면 build가 다시 실행된다
      activeScreen = const QuestionsScreen();
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue, Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: activeScreen
        ),
      ),
    );
  }
}

// Google의 Material Design을 기반으로 UI를 쉽게 만들 수 있도록 도와줘