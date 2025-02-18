import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});
  // 여기까지만 쓴다면 startQuiz를 쓸수있다가 아니라 startQuiz를 받는다
  // 매개변수를 받는다 까지만 해석할수가 있는 것임

  final void Function() startQuiz;
  // 이것을 해주지 않으면 startQuiz는 생성자에서만 존재하고 사라진다->build에서사용불가
  // final 필드는 반드시 생성자에서 값을 받아야 한다

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 사진에 투명도를 줄수있는 두가지 방법
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: Color.fromARGB(150, 255, 255, 255),
          ),
          const SizedBox(height: 80),
          const Text(
            'Something',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            // 버튼에 아이콘 넣고싶을때
            onPressed: () {
              startQuiz();
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white
            ),
            icon: const Icon(Icons.arrow_right_alt, color: Colors.white,),
            label: Text('Click!!?'),
          )
        ],
      ),
    );
  }
}

// 생성자란?
// 객체가 생성될 때 호출되는 특별한 함수
// 클래스와 같은 이름을 가져야한다
// this. : 생성자에서 전달받은 값을 필드에 저장하는 역할을 함.