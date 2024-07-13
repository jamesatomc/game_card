
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import services to access SystemChrome
import 'package:dynamic_color/dynamic_color.dart';

import 'MenuScreen.dart'; // Import DynamicColorBuilder

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized
  SystemChrome.setPreferredOrientations([
    // Set preferred orientations
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
    return DynamicColorBuilder(
      builder: (light, dark) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: light ??
              ColorScheme.fromSeed(
                seedColor: Colors.green,
                brightness: Brightness.light,
              ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: dark ??
              ColorScheme.fromSeed(
                seedColor: Colors.green,
                brightness: Brightness.dark,
              ),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: MenuScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
