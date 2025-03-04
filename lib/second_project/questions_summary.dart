import 'package:first_app/second_project/data/questions.dart';
import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            print(data);
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center, // 텍스트 중앙 정렬
                  decoration: BoxDecoration(
                    color: data['correct_answer'] == data['user_answer']
                        ? Colors.pink
                        : Colors.blue, // 배경색 설정
                    borderRadius: BorderRadius.circular(50), // 모서리 둥글게 (옵션)
                  ),
                  child: Text(
                    ((data['question_index'] as int) + 1).toString(),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['question'] as String,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        data['user_answer'] as String,
                        style: TextStyle(color: Colors.pink),
                      ),
                      Text(
                        data['correct_answer'] as String,
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ],
                  ),
                )
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
