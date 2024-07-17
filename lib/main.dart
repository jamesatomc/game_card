import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import services to access SystemChrome
import 'package:dynamic_color/dynamic_color.dart';

import 'gamecard/MenuScreen.dart'; // Import DynamicColorBuilder

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized
  SystemChrome.setPreferredOrientations([
    // Set preferred orientations
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    // Hide status bar and set full-screen mode
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

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
        home: games(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


class games extends StatefulWidget {
  const games({ Key? key }) : super(key: key);

  @override
  _gamesState createState() => _gamesState();
}

class _gamesState extends State<games> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                );
              },
              child: Text('Menu'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameWidget(game: MyGame())), // Wrap MyGame in GameWidget
                );
              },
              child: Text('games 2'), // Changed the text to "MyGame"
            ),
          ]
        ),
      ),
    );
  }
}




class MyGame extends FlameGame {
  @override
  void onLoad() {
    
  }
}
