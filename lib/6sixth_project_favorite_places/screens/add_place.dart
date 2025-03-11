import 'dart:convert';
import 'package:first_app/6sixth_project_favorite_places/models/place.dart';
import 'package:first_app/6sixth_project_favorite_places/providers/places_provider.dart';
import 'package:first_app/6sixth_project_favorite_places/widgets/image_input.dart';
import 'package:first_app/6sixth_project_favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});
  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends ConsumerState<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  var _enteredTitle = '';
  var _isSending = false;

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });
    }
    _formKey.currentState!.save();

    if (_enteredTitle.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      setState(() {
        _isSending = false;
      });
      return;
    }
    print(_selectedImage);
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(_enteredTitle, _selectedImage!, _selectedLocation!);

    setState(() {
      _isSending = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 50,
                    decoration: InputDecoration(
                      label: Text(
                        'Title',
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 50) {
                        return 'Must be between 1 and 50 characters. ';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredTitle = value!;
                    },
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  // 이미지 인풋을 넣을 것이다
                  ImageInput(onPickImage: (image) {
                    _selectedImage = image;
                    // 여기서 최종적으로 이미지를 받은 것이다
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  LocationInput(onSelectLocation: (location) {
                    _selectedLocation = location;
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: _isSending ? null : _saveItem,
                    child: _isSending
                        ? SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : Row(
                            mainAxisSize:
                                MainAxisSize.min, // 자식 위젯의 크기에 맞게 버튼 크기 설정
                            children: [
                              Icon(Icons.add), // 왼쪽 아이콘
                              SizedBox(width: 8), // 아이콘과 텍스트 사이 간격 추가
                              Text('Add Item'), // 오른쪽 텍스트
                            ],
                          ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
