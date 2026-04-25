import 'package:flutter/material.dart';

import '../controllers/place_controller.dart';
import '../models/place.dart';
import '../widgets/place_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.controller,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  final PlaceController controller;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _searchOpen = false;
  bool _fabExpanded = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        width: _fabExpanded ? 162 : 62,
        height: 62,
        child: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              _fabExpanded = !_fabExpanded;
            });
          },
          label: AnimatedOpacity(
            duration: const Duration(milliseconds: 220),
            opacity: _fabExpanded ? 1 : 0,
            child: const Text('Create Plan'),
          ),
          icon: AnimatedRotation(
            duration: const Duration(milliseconds: 260),
            turns: _fabExpanded ? 0.125 : 0,
            child: const Icon(Icons.add),
          ),
          backgroundColor: const Color(0xFF624AF1),
          foregroundColor: Colors.white,
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Color(0xFF5A4BEE), Color(0xFF4C86FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {},
                          color: Colors.white,
                          icon: const Icon(Icons.menu_rounded),
                        ),
                        Text(
                          'Explore Places',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _searchOpen = !_searchOpen;
                            });
                            if (!_searchOpen) {
                              _searchController.clear();
                              widget.controller.setQuery('');
                            }
                          },
                          color: Colors.white,
                          icon: const Icon(Icons.search),
                        ),
                        IconButton(
                          onPressed: widget.onToggleTheme,
                          color: Colors.white,
                          icon: Icon(
                            widget.isDarkMode
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                          ),
                        ),
                      ],
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 320),
                      curve: Curves.easeInOut,
                      height: _searchOpen ? 54 : 0,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 240),
                        opacity: _searchOpen ? 1 : 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: TextField(
                            controller: _searchController,
                            onChanged: widget.controller.setQuery,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: 'Search places',
                              hintStyle: const TextStyle(color: Colors.white70),
                              prefixIcon: const Icon(
                                Icons.travel_explore,
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: Colors.white.withAlpha(32),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: AnimatedBuilder(
              animation: widget.controller,
              builder: (BuildContext context, _) {
                final List<Place> places = widget.controller.places;

                if (places.isEmpty) {
                  return Center(
                    child: Text(
                      'No places found',
                      style: theme.textTheme.titleMedium,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: places.length,
                  padding: const EdgeInsets.only(top: 8, bottom: 90),
                  itemBuilder: (BuildContext context, int index) {
                    final Place place = places[index];
                    return PlaceCard(
                      place: place,
                      isFavorite: widget.controller.isFavorite(place.id),
                      onFavoriteTap: () =>
                          widget.controller.toggleFavorite(place),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => DetailScreen(
                              place: place,
                              isFavorite: widget.controller.isFavorite(
                                place.id,
                              ),
                              onFavoriteTap: () {
                                widget.controller.toggleFavorite(place);
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
