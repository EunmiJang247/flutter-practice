import 'dart:convert';
import 'package:first_app/5fifth_project_shopping/data/categories.dart';
import 'package:first_app/5fifth_project_shopping/models/grocery_item.dart';
import 'package:first_app/5fifth_project_shopping/screens/new_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  // 여기서 new_item에서 보낸 데이터들을 받는다
  List<GroceryItem> _groceryItems = [];
  // 나중에 정의될꺼라는 의미로 late를 추가한다
  // 퓨처를 사용하므로 주석처리
  // var _isLoading = true;
  // 에러 처리를 위한 변수 선언

  // 퓨처 변수 선언!
  late Future<List<GroceryItem>> _loadedItems;

  String? _error;

  @override
  void initState() {
    // 처음 진입했을 때 get요청으로 아이템들을 불러옴
    super.initState();
    _loadedItems = _loadItems();
  }

  // 퓨처 빌더를 써야하므로 주석처리
  // void _loadItems() async {
  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(
        'meditation-friend-default-rtdb.firebaseio.com', 'shopping-list.json');

    // 받은 데이터를 볼수있다!
    // print(response.body);

    // dart의 try, catch사용방법
    // 퓨러빌더 쓰므로 주석처리!
    // try {
    final response = await http.get(url);

    // 에러 처리에 대해 알아보자
    print(response.statusCode);
    if (response.statusCode >= 400) {
      // 에러처리는 여기서 일어난다
      setState(() {
        _error = "Failed to fetch data. Please try again";
      });
      // return; // 리턴 필수!! 안하면 밑에 함수로 넘어가버림
      // 퓨처빌더는 []를 반환해줘야함
      return [];
    }

    // 데이터가 없을 때의 에러처리를 하기
    if (response.body == 'null') {
      // setState(() {
      //   _isLoading = false;
      // });
      // return;
      // 퓨처빌더는 []를 반환해줘야함
      return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;
      loadedItems.add(GroceryItem(
        id: item.key,
        name: item.value['name'],
        quantity: item.value['quantity'],
        category: category,
      ));
    }
    // 퓨처를 써야하므로 주석처리!
    // setState(() {
    //   _groceryItems = loadedItems;
    //   _isLoading = false;
    // });
    return loadedItems;
    // } catch (error) {
    // setState(() {
    // _error = "Failed to fetch data. Please try again!";
    // });
    // }
  }

  void _addItem() async {
    // 새로운 메뉴 생성하는 페이지로 이동하는 부분
    // 파이어 베이스 쓰니까 주석처리!
    // final newItem =
    //     await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
    //   builder: (ctx) => const NewItem(),
    // ));

    // if (newItem == null) {
    //   return;
    // }

    // setState(() {
    //   _groceryItems.add(newItem);
    // });

    // 여기서 new_item에서 보낸 데이터를 받는 방법
    // 1.async를 단다
    // 2.await를 단다
    // 3.newItem으로 정의한다

    // 이제 파이어베이스에서 우리 앱으로 데이터를 불러와보자
    // 1. http를 import한다
    // 2. url을 선언한다

    // 파이어 베이스 쓰는 코드로 변경 아랫부분
    // await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
    //   builder: (ctx) => const NewItem(),
    // ));

    // newItem스크린에서 추가하고나서 돌아올 때
    // 2번 loadItems를 호출하게 된다. 그래서 아래 주석처리.
    // 또 로드하는것 대신 로컬에서 더하겠다 newItem으로 이동
    // _loadItems();

    final newItem =
        await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
      builder: (ctx) => const NewItem(),
    ));

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    // https delete요청을 통해 파이어베이스에서 삭제해 보겠다
    // shopping-list/ 뒤에 아이디를 넣는 방식으로 삭제한다
    final url = Uri.https('meditation-friend-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      // Show error message

      // setState(() {
      // _groceryItems.insert(index, item);
      // 만약 에러가 났다면 다시 추가하는 것이다
      // 특정 위치에 insert하기 위해 insert를 써야한다
      // });

      // 퓨처에서 에러를 받기 때문에 여기서 throw error를 하면 된다
      throw Exception('Failed to fetch grocery items. Please..');
    }

    // await, async만들필요가 없다
    // 받아야 하는 id가 없기때문에 그냥 지우면 되니까!
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text('No items added yet!!!!'),
    );

    // if (_isLoading) {
    //   content = const Center(
    //     child: CircularProgressIndicator(),
    //     // 로딩스피너!
    //   );
    // }

    // 자주 나오는 패턴이니까 익혀둬!!
    // 퓨처빌더 쓰니까 아래는 불필요하지
    // if (_groceryItems.isNotEmpty) {
    //   content = ListView.builder(
    //     itemCount: _groceryItems.length,
    //     // 밀어서 삭제하는거 구현!!
    //     itemBuilder: (context, index) => Dismissible(
    //       onDismissed: (direction) {
    //         _removeItem(_groceryItems[index]);
    //       },
    //       key: ValueKey(_groceryItems[index].id),
    //       child: ListTile(
    //         title: Text(_groceryItems[index].name),
    //         leading: Container(
    //           width: 24,
    //           height: 24,
    //           color: _groceryItems[index].category.color,
    //         ),
    //         trailing: Text(
    //           _groceryItems[index].quantity.toString(),
    //         ),
    //       ),
    //     ),
    //   );
    // }

    // 퓨처를 쓰므로 주석처리!
    // if (_error != null) {
    //   content = Center(child: Text(_error!));
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      // body: content,
      // FutureBuilder을 사용해보자!
      body: FutureBuilder(
        future: _loadedItems,
        // 이렇게 하면 InitState될때 한번만 실행될 것이다
        builder: (content, snapshot) {
          // FutureBuilder: 비동기 작업(Future)이 완료될 때까지 UI를 동적으로 변경할 수 있도록 해주는 Flutter 위젯
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 응답을 기다리고 있는 상태
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // 에러가 있는 상태
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No items added yet'),
            );
          }

          // 에러 없을 때 나올것들
          return ListView.builder(
            itemCount: snapshot.data!.length,
            // 밀어서 삭제하는거 구현!!
            itemBuilder: (context, index) => Dismissible(
              onDismissed: (direction) {
                _removeItem(_groceryItems[index]);
              },
              key: ValueKey(snapshot.data![index].id),
              child: ListTile(
                title: Text(snapshot.data![index].name),
                leading: Container(
                  width: 24,
                  height: 24,
                  color: snapshot.data![index].category.color,
                ),
                trailing: Text(
                  snapshot.data![index].quantity.toString(),
                ),
              ),
            ),
          );
          //
        },
      ),
    );
  }
}

// no items 에러처리

// 퓨처빌더의 단점
// FutureBuilder는 build() 메서드가 실행될 때마다 future를 다시 실행하려고 할 수도 있음
// 이를 방지하려면 future를 변수로 저장하거나, initState()에서 Future를 미리 호출해야 함


// 퓨처빌더 완료
// 하지만 이 앱은 바로 삭제해야 하는 기능이 있고 추가해야 하는 기능이 있어서 사실 FutureBuilder는 
// 틀린 방법이다. 쓰지 않는 방향으로 개발해야 한다