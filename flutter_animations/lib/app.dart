import 'package:flutter/material.dart';

import 'controllers/place_controller.dart';
import 'views/home_screen.dart';

class PlacesApp extends StatefulWidget {
  const PlacesApp({super.key});

  @override
  State<PlacesApp> createState() => _PlacesAppState();
}

class _PlacesAppState extends State<PlacesApp> {
  late final PlaceController _controller;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _controller = PlaceController.sample();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explore Places',
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5A4BEE)),
        scaffoldBackgroundColor: const Color(0xFFF3F4F8),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5A4BEE),
          brightness: Brightness.dark,
        ),
      ),
      home: HomeScreen(
        controller: _controller,
        isDarkMode: _isDarkMode,
        onToggleTheme: () {
          setState(() {
            _isDarkMode = !_isDarkMode;
          });
        },
      ),
    );
  }
}
