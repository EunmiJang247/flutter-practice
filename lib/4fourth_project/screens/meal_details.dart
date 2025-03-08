import 'package:first_app/4fourth_project/models/meal.dart';
import 'package:flutter/material.dart';
// 즐겨찾기 선택/해제를 위해 함수 내려받음
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_app/4fourth_project/providers/favorites_provider.dart';

// class MealDetailsScreen extends StatelessWidget { 리버팟 쓰기위해 아래로 바꿈
class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // WidgetRef는 Riverpod에서 제공하는 객체로, ref.watch(), ref.read(), ref.listen() 등을 이용해 프로바이더(provider) 값을 읽거나 구독할 수 있다
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              onPressed: () {
                final wasAdded = ref
                    .read(favoriteMealsProvider.notifier)
                    .toggleMealFavoriteStatus(meal);
                // StateNotifierProvider<FavoriteMealsNotifier,...로 선언이 되어있기 때문에 .notifier로 불러옴
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      wasAdded ? 'Meal added as a Favorite' : 'Meal removed'),
                ));
              },
              icon: Icon(isFavorite ? Icons.star : Icons.star_border),
            )
          ],
        ),
        body: SingleChildScrollView(
          // 스크롤을 위해 Column을 SingleChildScrollView로 감쌌다
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(
                height: 14,
              ),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              const SizedBox(
                height: 14,
              ),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(
                height: 14,
              ),
              for (final step in meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
            ],
          ),
        ));
  }
}
