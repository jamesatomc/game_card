import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import services to access SystemChrome

import 'MenuScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure plugin services are initialized
  SystemChrome.setPreferredOrientations([ // Set preferred orientations
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(const MyApp()); // Run app after setting orientation
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Game Card',
      home: const MenuScreen(),
    );
  }
}