import 'package:first_app/6sixth_project_favorite_places/models/place.dart';
import 'package:first_app/6sixth_project_favorite_places/screens/map.dart';
import 'package:flutter/material.dart';

class PlaceDetailSceen extends StatelessWidget {
  const PlaceDetailSceen({super.key, required this.place});

  final Place place;

  String get locationImage {
    final lat = place.location.latitude;
    final lng = place.location.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x400&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyDLuI361e6q0PXtUKfxPY0YGCYDYHYZKWY';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  // 온탭을 하기위해서 GestureDetector로 감쌌음
                  onTap: () {
                    // 맵스크린을 열겠다
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => MapScreen(
                              location: place.location,
                              isSelecting: false,
                            )));
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(locationImage),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(place.location.address,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
