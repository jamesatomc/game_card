import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:dynamic_color/dynamic_color.dart';
import 'dart:async';
import 'loading_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// ืNote: Uncomment the following code to enable dynamic color switching
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return DynamicColorBuilder(
//       builder: (light, dark) => MaterialApp(
//         title: 'Games to enhance English skills (Grade 5)',
//         theme: ThemeData(
//           colorScheme: light ?? 
//               ColorScheme.fromSeed(
//                 seedColor: Colors.blueAccent,
//                 brightness: Brightness.light,
//               ),
//           useMaterial3: true,
//         ),
//         darkTheme: ThemeData(
//           colorScheme: dark ?? 
//               ColorScheme.fromSeed(
//                 seedColor: Colors.blueAccent,
//                 brightness: Brightness.dark,
//               ),
//           useMaterial3: true,
//         ),
//         themeMode: ThemeMode.system,
//         home: SplashScreen(),
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }


class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games to enhance English skills (Grade 5)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: InitialScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(''), // Replace with your background image asset
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 1000,
            child: Center(
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'PixelFont',
                  color: Colors.white,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('เกมเสริมทักษะอังกฤษ'),
                  ],
                  isRepeatingAnimation: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DeveloperInfoScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset('assets/gamecard/logo1.png'), // Replace with your logo asset
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset('assets/gamecard/logo2.png'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeveloperInfoScreen extends StatelessWidget {
  const DeveloperInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Automatically navigate to LoadingScreen after 3 seconds
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoadingScreen()),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Developer Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Jiraphon Wansai\n Onusa Bunsorn\n Monticha Saengthong',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
