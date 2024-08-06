import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'gamecard/GameCard.dart';

import 'package:flutter_cardgame/game2/components/gogame.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (light, dark) => MaterialApp(
        title: 'Games to enhance English skills (Grade 5)',
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
        home: const ManuGame(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class ManuGame extends StatefulWidget {
  const ManuGame({Key? key}) : super(key: key);

  @override
  _ManuGameState createState() => _ManuGameState();
}

class _ManuGameState extends State<ManuGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/gamecard/one.gif'), // Replace with your GIF path
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [         
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameWidget(
                        game: MyGame(),
                        overlayBuilderMap: {
                          'BackButton': (context, game) => BackButtonOverlay(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        },
                      ),
                    ),
                  );
                },
                child: const Text('ManuGame 1'),
              ),
              const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GameCardScreen()),
                  );
                },
                child: const Text('เกมส์จับคู่รูปภาพกับคำอังกฤษ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}