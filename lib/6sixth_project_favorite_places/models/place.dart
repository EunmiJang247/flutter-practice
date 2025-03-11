import 'package:uuid/uuid.dart';
import 'dart:io';

final uuid = Uuid();

class PlaceLocation {
  const PlaceLocation({
    required this.latitue,
    required this.longtitude,
    required this.address,
  });

  final double latitue;
  final double longtitude;
  final String address;
}

class Place {
  Place({
    required this.title,
    required this.image,
    required this.location,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
}
