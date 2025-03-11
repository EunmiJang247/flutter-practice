import 'package:first_app/6sixth_project_favorite_places/models/place.dart';
import 'package:first_app/6sixth_project_favorite_places/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // PlaceLocation 타입 쓰려면 필요!

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  // flutter pub add location 로 패키지 추가함
  // https://pub.dev/packages/location 여기서 가져온 코드를 붙여다넣음
  // async 를 붙임
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;

  // 게터 설정
  // get이란 뭘까.. 왜 변수설정으로 하지 않는걸까
  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }

    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x400&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyDLuI361e6q0PXtUKfxPY0YGCYDYHYZKWY';
  }

  Future<void> _savePlace(double latitude, double longitude) async {
    // 위도와 경도로 주소를 뽑아내는 api 호출하기
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyDLuI361e6q0PXtUKfxPY0YGCYDYHYZKWY');

    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];
    print(address);

    setState(() {
      _pickedLocation = PlaceLocation(
          latitude: latitude, longitude: longitude, address: address);
      _isGettingLocation = false;
    });
    widget.onSelectLocation(_pickedLocation!);
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print('위치 서비스가 비활성화됨');
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print('위치 권한이 거부됨');
        return;
      }
    }
    setState(() {
      _isGettingLocation = true;
    });
    try {
      locationData = await location.getLocation();

      print(locationData.latitude);
      print(locationData.longitude);

      final lat = locationData.latitude;
      final lng = locationData.longitude;

      if (lat == null || lng == null) {
        return;
      }
      _savePlace(lat, lng);
    } catch (e) {
      print('위치 가져오기 실패: $e');
      setState(() {
        _isGettingLocation = false;
      });
    }
  }

  void _selectOnMap() async {
    // 지도에서 고르기 버튼 눌렀을 때!
    print('hi');
    final pickedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      builder: (ctx) => const MapScreen(),
    ));

    if (pickedLocation == null) {
      return;
    }
    _savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );

    if (_pickedLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2))),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('현재위치 가져오기'),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('지도에서 고르기'),
              onPressed: _selectOnMap,
            )
          ],
        )
      ],
    );
  }
}
