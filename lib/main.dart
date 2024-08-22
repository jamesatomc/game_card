import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_cardgame/game2/GmaeJump.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'gamecard/GameCard.dart';

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
  // ignore: use_super_parameters
  const ManuGame({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ManuGameState createState() => _ManuGameState();
}

class _ManuGameState extends State<ManuGame> {
  final TextEditingController _nameController = TextEditingController();
  String? _playerName;

  @override
  void initState() {
    super.initState();
    _loadPlayerName();
  }

  Future<void> _loadPlayerName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _playerName = prefs.getString('playerName');
      _nameController.text = _playerName ?? '';
    });
  }

  Future<void> _savePlayerName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('playerName', name);
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource(
        'sounds/button_click.mp3')); // Adjust the path to your sound file
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/gamecard/one.gif'),
            fit: BoxFit.cover,
          ),
          color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display Player Name (Editable)
              SizedBox(
                width: 300, // Increased width for better appearance
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(
                          255, 97, 208, 191), // Light background color
                      prefixIcon:
                          Icon(Icons.person), // Icon inside the text field
                    ),
                    onChanged: (text) {
                      _savePlayerName(text); // Save name as the user types
                      setState(() {
                        _playerName = text;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 90,
                width:
                    260, // Makes the button take the full width of its parent
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 16),
                    textStyle: const TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    _playSound();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GameCardScreen()),
                    );
                  },
                  // ignore: prefer_const_constructors
                  child: Text(
                    'Game 1',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 90,
                width:
                    260, // Makes the button take the full width of its parent
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 16),
                    textStyle: const TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    _playSound();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GmaeJump()),
                    );
                  },
                  child: const Text('Game 2'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
