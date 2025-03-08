import 'package:first_app/4fourth_project/data/dummy_data.dart';
import 'package:first_app/4fourth_project/models/category.dart';
import 'package:first_app/4fourth_project/models/meal.dart';
import 'package:first_app/4fourth_project/screens/meals.dart';
import 'package:first_app/4fourth_project/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  // 카테고리 화면을 아래에서 위로 올라오는 애니메이션을 추가하겠다.
  // Stateless -> Stateful로 바꿔야함!
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // 애니메이션 컨트롤러를 위해 initState 추가함!
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, // ✅ TickerProviderStateMixin을 사용해서 vsync 설정
      duration: Duration(milliseconds: 300),
      lowerBound: 0, // 애니메이션의 최소값 (기본값: 0)
      upperBound: 1, // 애니메이션의 최대값 (기본값: 1)
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose(); // ✅ 메모리 누수를 방지하기 위해 dispose()에서 정리
    super.dispose();
  }

  // 카테고리를 선택할 때 실행되는 함수
  void _selectCategory(
    BuildContext context,
    Category category,
  ) {
    // StatelessWidget에 메서드를 만든다
    var meals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MealsScreen(title: category.title, meals: meals)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        // 스크롤이 가능하다 default 기능
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        // 아래, 위 둘다 가능!
        // children: availableCategories.map((category) => CategoryGridItem(category: category)).toList()
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                })
        ],
      ),
      // builder: (context, child) => Padding(
      //     padding:
      //         EdgeInsets.only(top: 100 - _animationController.value * 100),
      //     child: child));

      // 위와 같음. 필러터 SlideTransition 사용하기
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOut)),
        child: child,
      ),
    );
  }
}
