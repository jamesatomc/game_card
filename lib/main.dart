// import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import services to access SystemChrome
import 'package:dynamic_color/dynamic_color.dart';

import 'gamecard/GameCard.dart'; // Import DynamicColorBuilder

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
        systemNavigationBarColor: Colors.transparent, // Hide navigation bar
        systemNavigationBarDividerColor: Colors.transparent, // Hide navigation bar divider
        systemNavigationBarIconBrightness: Brightness.light, // Set navigation bar icon brightness
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // Full-screen mode

    runApp(const MyApp()); // Run app after setting orientation
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (light, dark) => MaterialApp(
        title: 'ทดสอบ',
        theme: ThemeData(
          colorScheme: light ??
              ColorScheme.fromSeed(
                seedColor: Colors.blueAccent,
                brightness: Brightness.light,
              ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: dark ??
              ColorScheme.fromSeed(
                seedColor: Colors.blueAccent,
                brightness: Brightness.dark,
              ),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: ManuGame(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


class ManuGame extends StatefulWidget {
  const ManuGame({ Key? key }) : super(key: key);

  @override
  _ManuGameState createState() => _ManuGameState();
}

class _ManuGameState extends State<ManuGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // This centers the buttons vertically in the Column
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameCardScreen()),
                );
              },
              child: Text('Game Card'),
            ),
            // SizedBox(height: 16), // Add some spacing between the buttons
            // OutlinedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => GameWidget(game: MyGame())), // Wrap MyGame in GameWidget
            //     );
            //   },
            //   child: Text('ManuGame 2'), // Changed the text to "MyGame"
            // ),
          ],
        ),
      ),
    );
  }
}

// class MyGame extends FlameGame {
//   @override
//   void onLoad() {
    
//   }
// }
