import 'package:first_app/4fourth_project/screens/tabs.dart';
import 'package:first_app/4fourth_project/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

// 프로바이더 쓰기위해 리버팟 impot
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 필터 프로바이더 Import
import 'package:first_app/4fourth_project/providers/filters_provider.dart';

// 드로어에서 Filters선택하면 나오는 페이지
// class FiltersScreen extends StatefulWidget {
// 프로바이더 사용을 위해 아래와 같이 바꿈
// class FiltersScreen extends ConsumerStatefulWidget { // 이제 로컬로 관리하는 변수를 아예 없애기 위해 왼쪽 코드를 주석처리함
// ConsumerStatefulWidget -> ConsumerWidget
class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  // @override
  // State<StatefulWidget> createState() {
// 프로바이더 사용을 위해 아래와 같이 바꿈

// 이제 로컬로 관리하는 변수를 아예 없애기 위해 아래 코드를 주석처리함
//   ConsumerState<FiltersScreen> createState() {
//     return _FiltersScreenState();
//   }
// }

// class _FiltersScreenState extends State<FiltersScreen> {
// 프로바이더 사용을 위해 아래와 같이 바꿈

// class _FiltersScreenState extends ConsumerState<FiltersScreen> {
//   var _glutenFreeFilterSet = false;
//   var _lactoseFreeFilterSet = false;
//   var _vegetarianFilterSet = false;
//   var _veganFilterSet = false;

  // 이제 로컬로 관리하는 변수를 아예 없애기 위해 왼쪽 코드를 주석처리함
  // @override
  // void initState() {
  //   super.initState();
  //   // 여기서 기존의 필터셋을 상속받은 필터셋으로 변경할 것이다
  //   // _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
  //   // _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
  //   // _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
  //   // _veganFilterSet = widget.currentFilters[Filter.vegan]!;

  //   // 프로바이더 적용으로 변경
  //   // 프로바이더는 한번만 가져오면 되므로 read를 쓰는 것이다
  //   final activeFilters = ref.read(filtersProvider);
  //   _glutenFreeFilterSet = activeFilters[Filter.glutenFree]!;
  //   _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
  //   _vegetarianFilterSet = activeFilters[Filter.vegetarian]!;
  //   _veganFilterSet = activeFilters[Filter.vegan]!;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // WidgetRef ref를 사용한 이유는 리버팟(Riverpod) 상태 관리를 위해 ConsumerWidget으로 변경했기 때문

    final activeFilters = ref.watch(filtersProvider);
    // 각각 필터의 상태를 local이 아닌 프로바이더에서 관리하기 위함
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // 뒤로가기 대신 drawer을 설정하는 부분.
      // 이거를 설정하지 않으면 그냥 뒤로가기 < 버튼이 나온다
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (ctx) => const TabsScreen()));
      //   }
      // }),
      // body: PopScope(
      //   // Column을 PopScope로 감싸서 사용자가 뒤로 가기를 눌렀을 때
      //   // 특정 로직을 실행할 수 있도록 한다
      //   canPop: false,
      //   onPopInvokedWithResult: (bool didPop, dynamic result) {
      //     // 사용자가 뒤로 가기를 시도할 때 호출되는 콜백
      //     if (didPop) return; // 사용자가 이미 pop을 수행했다면 아무것도 하지 않음
      //     // 상태 관리 로직 실행
      //     ref.read(filtersProvider.notifier).setFilters({
      //       // 반환할 데이터를 쓴다. 이 데이터들은 tabs로 넘겨질 것이다
      //       Filter.glutenFree: _glutenFreeFilterSet,
      //       Filter.lactoseFree: _lactoseFreeFilterSet,
      //       Filter.vegetarian: _vegetarianFilterSet,
      //       Filter.vegan: _veganFilterSet,
      //     });
      //     // 현재 화면을 닫고 데이터 반환
      //     Navigator.of(context).pop();
      //   },
      //   child:

      body: Column(
        children: [
          // 글루텐프리 토글버튼
          SwitchListTile(
            value: activeFilters[
                Filter.glutenFree]!, // 이거는 ref.watch 위에 있는거를 추가해야함
            onChanged: (isChecked) {
              // setState(() {
              //   _glutenFreeFilterSet = isChecked;
              // });
              // 위를 아래와 같이 변경(각각 state도 local이 아닌 Provider에서 관리하기 위함)
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include gluten-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          // 유당불내 토글버튼
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include lactose-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          // 베지테리안 토글버튼
          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include lactose-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          // 비건 토글버튼
          SwitchListTile(
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include lactose-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
