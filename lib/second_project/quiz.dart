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
  // null 일수도 있기 때문에 ?를 붙인다

  @override
  void initState() {
    // build보다 먼저 실행된다
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  // 스크린을 바꿀때 형식은 Widget으로!
  void switchScreen() {
    setState(() {
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
