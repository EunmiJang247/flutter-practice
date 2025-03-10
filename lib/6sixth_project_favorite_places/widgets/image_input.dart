import 'package:flutter/material.dart';
// 이미지피커 라이브러리를 추가해야 한다
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// File type을 쓰기위해

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  // null이 될수있기 때문에 ?를 한다

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }
    final imageFile = File(pickedImage.path);
    // setState를 해야 찍은 사진이 나타난다
    setState(() {
      _selectedImage = imageFile;
    });

    // 패런트 위젯에 사진을 넘겨줘야함
    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
      onPressed: _takePicture,
    );
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );

      // 로딩된 이미지를 누르면 새 이미지로 대체하기 위해 GestureDetector을 추가한다
    }
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}

// 이미지 피커 패키지
// image_picker 이라는 라이브러리임
// flutter pub add image_picker
// ios 폴더 -> Runner -> infoplist 파일 연다

// 아래 추가함 Ios만 하면됌!
// <key>NSPhotoLibraryUsageDescription</key>
// <string>이미지를 고르세요</string>
// <key>NSCameraUsageDescription</key>
// <string>왜 카메라가 필요한지</string>
// <key>NSMicrophoneUsageDescription</key>
// <string>마이크 권한</string>
