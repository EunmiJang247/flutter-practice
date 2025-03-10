import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:first_app/5fifth_project_shopping/data/categories.dart';
import 'package:first_app/5fifth_project_shopping/models/category.dart';
import 'package:first_app/5fifth_project_shopping/models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;
  var _isSending = false;

  void _saveItem() async {
    // 밑에를 실행하면 유효성 검사가 실행된다
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });

      // 유효성 검사가 통과했을 때만 저장함
      _formKey.currentState!.save();
      // 이거는 각 필드의 onSaved: (value) {~ 를 실행한다
      // print(_enteredName) 그래서 이 가능함!!

      // http로 바꿀꺼라서 주석!
      // Navigator.of(context).pop(GroceryItem(
      //   id: DateTime.now().toString(),
      // name: _enteredName,
      // quantity: _enteredQuantity,
      // category: _selectedCategory,
      // ));

      // 위 코드를 백앤드로 요청보내는 거로 바꿔보겠다
      // http패키지 다운로드: flutter pub add http
      // 이거 임포트 -> import 'package:http/http.dart' as http;

      // POST 요청 보내기
      final url = Uri.https('meditation-friend-default-rtdb.firebaseio.com',
          'shopping-list.json');
      // 두번째는 추가하고 싶은 경로임!
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': _enteredName,
          'quantity': _enteredQuantity,
          'category': _selectedCategory.title,
        }),
      );
      print(response.statusCode);

      // 아래처럼 그냥 꺼서는 안된다. 왜냐면 http요청이 오는동안 context가 보이지 않기 때문이다
      // Navigator.of(context).pop();

      // 대신 아래처럼 해야한다.
      // if (!context.mounted) {
      //   return;
      // }
      // Navigator.of(context).pop();
      // grocery_list로 이동!

      // 또 로드하는것 대신 로컬에서 더하겠다 기존 Navigator.of(context).pop();을 아래와같이 변경
      final Map<String, dynamic> resData = json.decode(response.body);

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(GroceryItem(
          id: resData['name'],
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _selectedCategory));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            // 유효성 검사하라고 명령
            // key를 적음으로써 GlobalKey의 formKey를 설정한다
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  // Form위젯에서는 TextField가 아닌 TextFormField를 써야한다
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                  validator: (value) {
                    // null 반환되면 validation 통과했다는 뜻임
                    // 아니면 통과 못했다는 거고
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Must be between 1 and 50 characters. ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // if (value == null) {
                    //   return; --> 이거를 안해도됌 왜나면
                    //   if (value == null ||~~ validator 에 이미 선언했으니까
                    // }
                    _enteredName = value!;
                    // _enteredName과함께 사용
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text('Quantity'),
                        ),
                        keyboardType: TextInputType.number,
                        initialValue: _enteredQuantity.toString(),
                        validator: (value) {
                          // null 반환되면 validation 통과했다는 뜻임
                          // 아니면 통과 못했다는 거고
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return 'Must be between 1 and 50 characters. ';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredQuantity = int.parse(value!);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _selectedCategory,
                        // 이니셜벨류는 여기에 적는다!
                        isExpanded: true,
                        items: [
                          for (final category in categories.entries)
                            // .entries로 객체를 리스트로 형변환 해준다
                            DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    color: category.value.color,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(category.value.title),
                                ],
                              ),
                            ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: _isSending
                            ? null
                            : () {
                                _formKey.currentState!.reset();
                              },
                        child: const Text('Reset')),
                    ElevatedButton(
                        onPressed: _isSending ? null : _saveItem,
                        // 로딩스피너가 버튼 안에 들어감!
                        child: _isSending
                            ? SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Add Item')),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
