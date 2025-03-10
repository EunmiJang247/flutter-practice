import 'package:first_app/6sixth_project_favorite_places/providers/places_provider.dart';
import 'package:first_app/6sixth_project_favorite_places/screens/add_place.dart';
import 'package:first_app/6sixth_project_favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        child: PlacesList(places: userPlaces),
      );
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
