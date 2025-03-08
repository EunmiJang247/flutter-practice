import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_app/4fourth_project/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  // 리버팟에서 제공하는 StateNotifier 이다
  FavoriteMealsNotifier() : super([]);
  // super 을 통해 초기값인 []을 전달한다

  // 데이터를 수정할 수 있는 메서드
  bool toggleMealFavoriteStatus(Meal meal) {
    // 초기값인 []를 수정하지 않는다.
    // 항상 메모리에 새로운 object와 주소를 만들어야 한다
    // 그게 리버팟.
    final mealIsFavorite = state.contains(meal);
    // state에 선택된 meal이 포함되어있는지 여부를 나타냄

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // 기존 리스트에 새로운 meal을 추가한다
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
// StateNotifierProvider를 써야 favorite meals를 업데이트 할수있다!
