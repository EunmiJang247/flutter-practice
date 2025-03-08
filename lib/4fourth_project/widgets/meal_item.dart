import 'package:first_app/4fourth_project/models/meal.dart';
import 'package:first_app/4fourth_project/screens/meal_details.dart';
import 'package:first_app/4fourth_project/widgets/meal_item_trait.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  // getter 설정
  String get completxityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  // getter 설정
  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      // 처음에는 이 Round가 설정되지 않는데, Stack이기 때문에 그냥 잘리지 않고 쌒이는 것이기 때문이다
      clipBehavior: Clip.hardEdge,
      // 그래서 Clip.hardEdge 이거를 적용해야 Round가 더해진다
      // 카드 모양 이상으로 벗어나는거 자름
      elevation: 2,
      child: InkWell(
        // onTap을 구현하기 위해 Inkwell을 쓴 것이다
        onTap: () {
          onSelectMeal(meal);
          // 여기 context는 뭐지?
        },
        child: Stack(
          // Stack은 위로 쌓을 수 있는 플러터의 기능!
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              // dart pub add transparent_image해서 설치한다
              // NetworkImage: 인터넷에서 사진을 불러온다
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 44),
                child: Column(
                  // Positioned는 이 Column이 Positioned의 넓이만을 차지하도록 한다
                  // 그래서 고정된 넓이를 갖게 된다
                  // 그래서 MealItemTrait 위젯에서 Row를 또 갖더라도 Expanded로 감쌀필요가 없다
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2, // 제목이 너무길면 잘라냄
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // 긴 부분은 ...로 나타냄
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          label: completxityText,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.money,
                          label: affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
