import 'package:flutter/foundation.dart';

import '../models/place.dart';

class PlaceController extends ChangeNotifier {
  PlaceController(this._allPlaces);

  final List<Place> _allPlaces;
  final Set<String> _favoriteIds = <String>{};
  String _query = '';

  factory PlaceController.sample() {
    return PlaceController(const <Place>[
      Place(
        id: 'lake-saif-ul-malook',
        name: 'Lake Saif ul Malook',
        location: 'Pakistan',
        imageUrl:
            'https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=1200&q=80',
        description:
            'A beautiful alpine lake located in the Kaghan Valley, surrounded by snow-capped mountains and lush green meadows.',
        elevation: '3,224 m',
        type: 'Lake',
        bestTime: 'May - Sep',
      ),
      Place(
        id: 'hunza-valley',
        name: 'Hunza Valley',
        location: 'Pakistan',
        imageUrl:
            'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1200&q=80',
        description:
            'Famous for its breathtaking mountainous views, glacier-fed rivers, and vibrant local culture.',
        elevation: '2,438 m',
        type: 'Valley',
        bestTime: 'Apr - Oct',
      ),
      Place(
        id: 'fairy-meadows',
        name: 'Fairy Meadows',
        location: 'Pakistan',
        imageUrl:
            'https://images.unsplash.com/photo-1601758123927-1963d7f1b8c9?auto=format&fit=crop&w=1200&q=80',
        description:
            'A lush green plateau near Nanga Parbat, known for camping, hiking, and dramatic sunrise views.',
        elevation: '3,300 m',
        type: 'Plateau',
        bestTime: 'Jun - Aug',
      ),
      Place(
        id: 'derawar-fort',
        name: 'Derawar Fort',
        location: 'Pakistan',
        imageUrl:
            'https://images.unsplash.com/photo-1605538883669-82541e18f6ef?auto=format&fit=crop&w=1200&q=80',
        description:
            'A historic desert fortress with imposing bastions, set against warm sandstone dunes.',
        elevation: '112 m',
        type: 'Fort',
        bestTime: 'Nov - Feb',
      ),
    ]);
  }

  List<Place> get places {
    if (_query.trim().isEmpty) {
      return _allPlaces;
    }

    final String normalizedQuery = _query.trim().toLowerCase();
    return _allPlaces
        .where((Place place) {
          return place.name.toLowerCase().contains(normalizedQuery) ||
              place.location.toLowerCase().contains(normalizedQuery);
        })
        .toList(growable: false);
  }

  bool isFavorite(String id) => _favoriteIds.contains(id);

  void toggleFavorite(Place place) {
    if (_favoriteIds.contains(place.id)) {
      _favoriteIds.remove(place.id);
    } else {
      _favoriteIds.add(place.id);
    }
    notifyListeners();
  }

  void setQuery(String value) {
    if (_query == value) {
      return;
    }
    _query = value;
    notifyListeners();
  }
}
