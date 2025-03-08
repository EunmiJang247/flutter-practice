import 'package:first_app/4fourth_project/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 프로바이더를 사용하기 위해 추가해야 한다

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
