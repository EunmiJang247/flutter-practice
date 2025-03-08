import 'package:first_app/4fourth_project/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 사용자가 선택할 수 있는 필터 옵션을 정의한 열거형(enum)
enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  // StateNotifier<Map<Filter, bool>>을 상속받아 Riverpod에서 필터 상태를 관리하는 클래스
  // Map<Filter, bool>: 각 필터(Filter)의 상태(bool)를 저장하는 데이터 구조
  // StateNotifier는 Riverpod에서 상태 변경을 위한 클래스

  // super를 사용하여 필터 상태의 초기값을 설정
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  // 여러 필터 상태를 한 번에 변경하는 메서드
  // 아래와 같이 사용함
  // ref.read(filtersProvider.notifier).setFilters({
  void setFilters(Map<Filter, bool> chosenFilters) {
    print(chosenFilters);
    state = chosenFilters;
  }

  // 단일 필터 상태를 변경하는 메서드
  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
        // StateNotifierProvider를 사용하여 FilterNotifier를 전역 상태로 등록
        (ref) => FilterNotifier());

// 사용 예시
// 현재 필터 상태를 읽을 때 사용
// final filters = ref.watch(filtersProvider);

// 특정 필터의 상태 변경
// ref.read(filtersProvider.notifier).setFilter(Filter.glutenFree, true);

// 아래는 멀티 프로바이더에 대해 배우겠다
// 필터 프로바이더와 밀접한 관련이 있으므로 이 파일에 같이 쓰는 것이다

// 아래의 filteredMealsProvider는 filter Provider에도 영향을 받고 meals provider에도 영향을 받는다
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(
      mealsProvider); // 이렇게 설정하면 watch는 meals가 변경되는지 계속 지켜보다가 변하면 return을 한번더 실행시킴
  final activeFilters = ref.watch(
      filtersProvider); // 이렇게 설정하면 watch는 filters가 변경되는지 계속 지켜보다가 변하면 return을 한번더 실행시킴
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      // 글루틴 프리 필터가 참이고 메뉴에 글루틴 프리가 false일때
      // 해당 메뉴를 제외해야 하기 때문에 false를 반환하는 것이다
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
    // if에 해당하지 않은 것에는 true를 반환해서 모두 반환하게 한다
  }).toList();
});
