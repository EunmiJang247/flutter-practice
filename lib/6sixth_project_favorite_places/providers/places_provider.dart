import 'dart:io';
import 'package:first_app/6sixth_project_favorite_places/models/place.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

// final placesProvider = Provider((ref) {
//   return dummyPlaces;
// });

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      // places.db이게 처음으로 생성될 때 실행될 것이다
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
      // path만 저장할꺼기 때문에 이미지도 text
    },
    version: 1,
    // 쿼리를 변경할때마다 version이 증가해야 한다
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  // 이제 데이터베이스에 저장한 데이터를 불러오는 코드!
  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
              latitude: row['lat'] as double,
              longitude: row['lng'] as double,
              address: row['address'] as String,
            ),
          ),
        )
        .toList();
    state = places;
    // 프로바이더의 state를 업데이트 한다
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    print('여기도!');
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    // getApplicationDocumentsDirectory를 사용하여 로컬 메모리에 접근하려고함
    final filename = path.basename(image.path);
    // path.basename()은 파일의 이름만 추출하는 함수이다.
    final copiedImage = await image.copy('${appDir.path}/$filename');
    // 복사된 이미지이다

    final newPlace =
        Place(title: title, image: copiedImage, location: location);

    final db = await _getDatabase();

    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
    // 여기까지가 로컬의 데이터베이스에 저장하는 코드!
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);

// 앱을 다시시작해도 데이터가 로컬에 남아있도록 해보겠다
// 이것을 위해 패키지를 다운받아야함.
// flutter pub add path_provider
// flutter pub add path
// flutter pub add sqflite -> 로컬에서 구동되는 데이터베이스.

// 전달 받은 이미지를 로컬디바이스에 저장해보겠다
