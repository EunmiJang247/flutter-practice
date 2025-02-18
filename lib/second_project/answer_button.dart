import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answer,
    required this.onTap
  });

  final String answer;
  final void Function() onTap;
  // final: 변수의 값이 한 번 할당되면 변경될 수 없도록
  // stateless니까 변지 않기 때문에
  // StatelessWidget에서 생성자로 받은 값은 대부분 final로 선언하는 것이 일반적인 패턴

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // ElevatedButton 앞에 const를 넣으면 안됌
      // const는 컴파일 타임에 값이 결정되어야 하는 불변 객체를 생성하는 키워드임.
      // 하지만 onTap과 answer는 런타임에 동적으로 전달되는 값이므로, const로 선언할 수 없음.
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        backgroundColor: const Color.fromARGB(255, 33, 1, 95),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))
      ),
      child: Text(
        answer,
        textAlign: TextAlign.center,
      ));
  }
}
