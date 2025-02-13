import 'package:first_app/first_project/gradient_container.dart';
import 'package:first_app/second_project/quiz.dart';
import 'package:flutter/material.dart';

void main() {
  // void: 반환유형 main: 함수이름
  // main()은 Flutter/Dart에서 자동으로 실행되는 함수이기 때문에 별도로 호출할 필요가 없어
  runApp( // Flutter 애플리케이션의 실행을 시작
    const Quiz()
  );
  // runApp()을 통해 최상위 위젯을 Flutter 엔진에 등록하면 화면이 그려짐
  // const를 붙이면 두번째로 랜더링 될때 두번째 메모리 개체가 생성되는 대신 기존 메모리가 재사용됨
  // 우클릭->리펙토링->Center 감싸기
  // 모든 )뒤에,를 치고 Cmd Shift P -> format document 클릭
}
// pubspec.yaml: 라이브러리 종속성 관리하는 곳

// dart는 객체지향언어이기 때문에 모든것이 Object로 작성된다.
// 내가 작성할 커스텀 위젯도 클라스로 작성해야 한다.

