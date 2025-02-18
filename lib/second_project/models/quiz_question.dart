class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    // 원본 answers를 변경하지 않기 위해 List.of를 쓴다
    // 즉, 새로운 메모리 주소에 저장
    shuffledList.shuffle();
    return shuffledList;
  }
}