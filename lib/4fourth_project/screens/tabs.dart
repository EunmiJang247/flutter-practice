import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_app/4fourth_project/screens/filters.dart';
import 'package:first_app/4fourth_project/screens/firstpage_categories.dart';
import 'package:first_app/4fourth_project/screens/meals.dart';
import 'package:first_app/4fourth_project/widgets/main_drawer.dart';
// import 'package:first_app/4fourth_project/providers/meals_provider.dart';
// 위에꺼 쓸려면 리버팟도 임포트 해야함(두번째줄에 했음)
import 'package:first_app/4fourth_project/providers/favorites_provider.dart';
// 아래와 같이 filter provider 쓸수있도록 선언함
import 'package:first_app/4fourth_project/providers/filters_provider.dart';

var kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

// class TabsScreen extends StatefulWidget { 리버팟을 쓰기때문에 아래처럼 변경함!
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  // State<TabsScreen> createState() {
  // 리버팟을 사용하기 때문에 아래와 같이 바꿈
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

// class _TabsScreenState extends State<TabsScreen> {
// 리버팟을 사용하기 때문에 아래와 같이 바꿈
class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // 프로바이더 써서 아래는 불필요
  // Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    // Filters의 PopScope에서 정보를 받기 때문에 async를 추가했다
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      // Navigator.of(context).pushReplacement(
      await Navigator.of(context).push<Map<Filter, bool>>(
        // 기존 push -> pushReplacement로 바꾸면 스택에 쌓이지 않고 페이지가 대체된다
        // < 버튼이 그냥 앱을 닫게 됨
        // <> 안에 들어가는 타입은 반환될 타입을 쓰는 것이다
        // key 타입은 Filter이 되는 것이고 결과는 bool이 되는 것이다

        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
      // 프로바이더 써서 아래는 불필요하다
      // setState(() {
      // _selectedFilters = result ?? kInitialFilters;
      // result가 null이면 ?? 다음에 대신 들어갈게 들어감
      // 그게 kInitialFilters임.
      // 이제 이걸로 카테고리 스크린을 업데이트할 것이다
      // });
      // 결과값: {Filter.glutenFree: true, Filter.lactoseFree: false, Filter.vegetarian: false, Filter.vegan: false}
      // 여기서 filters에서 넘겨진 데이터들을 받는다
      // 데이터를 전달하고 뒤로가기를 누르면 result 값이 나오게 되는 것이다
    }
  }

  @override
  Widget build(BuildContext context) {
    // 프로바이더에서 가져오기 위함
    // final meals = ref.watch(mealsProvider);
    // build에서 mealsProvider가 바뀔때마다 지켜봄
    // final activeFilters = ref.watch(filtersProvider);

    final availableMeals = ref.watch(filteredMealsProvider);
    // final availableMeals = meals.where((meal) {
    //   if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
    //     // 글루틴 프리 필터가 참이고 메뉴에 글루틴 프리가 false일때
    //     // 해당 메뉴를 제외해야 하기 때문에 false를 반환하는 것이다
    //     return false;
    //   }
    //   if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.vegan]! && !meal.isVegan) {
    //     return false;
    //   }
    //   return true;
    //   // if에 해당하지 않은 것에는 true를 반환해서 모두 반환하게 한다
    // }).toList();
    // where: 리스트를 필터링한다

    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      // 여기서 가져온다
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(meals: favoriteMeals);
      // 이게 여기있기 때문에 Favorit 은 여기서 상태가 관리 되어야 한다
      activePageTitle = 'Favorits';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      // 텝바를 만드는 부분이다
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        // 카테고리는 두개 필요하다. 카테고리 화면과 즐겨찾기 화면이다
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
