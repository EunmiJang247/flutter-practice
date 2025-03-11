import 'package:first_app/6sixth_project_favorite_places/providers/places_provider.dart';
import 'package:first_app/6sixth_project_favorite_places/screens/add_place.dart';
import 'package:first_app/6sixth_project_favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlaceScreenState();
  }
}

class _PlaceScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);
    void _addItem() async {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => const AddPlaceScreen(),
      ));
    }

    Widget content = Center(
      child: Text(
        'No items added yet!!!!',
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
    if (userPlaces.isNotEmpty) {
      content = Padding(
          padding: const EdgeInsets.all(8.0),
          // 데이터베이스에서 가져오고 그거를 여기서 보여주겠다
          child: FutureBuilder(
            future: _placesFuture,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : PlacesList(places: userPlaces),
          ));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Places',
        ),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: content,
    );
  }
}
