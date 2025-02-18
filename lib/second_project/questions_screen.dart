import 'package:first_app/second_project/answer_button.dart';
import 'package:flutter/material.dart';
import 'package:first_app/second_project/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(){
    setState(() {
      currentQuestionIndex += 1;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];
    print(currentQuestion);

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            ...currentQuestion.getShuffledAnswers().map((answer) {
              // ...(spread operator)를 써야 하는 이유
              // Flutter의 Column 위젯에서 children 속성은 
              //**위젯 리스트(List<Widget>)**를 받습니다. 
              //하지만 .map() 함수는 Iterable을 반환하므로,
              // 이를 리스트로 변환해 주어야 합니다. ...를 사용하면 
              //Iterable<Widget>을 List<Widget>로 펼쳐서(spread) 
              //전달할 수 있습니다.
        
              return AnswerButton(
                answer: answer,
                onTap: answerQuestion);
            }),
          ],
        ),
      ),
    );
  }
}
