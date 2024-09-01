import 'package:flutter/material.dart';
import 'package:flutter_cardgame/game1/components/LevelButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

// Import all level screens
import '../game_button.dart';
import 'Level/Level1Screen.dart';
import 'Level/Level2Screen.dart';
import 'Level/Level3Screen.dart';
import 'Level/Level4Screen.dart';
import 'Level/Level5Screen.dart';
import 'Level/Level6Screen.dart';
import 'Level/Level7Screen.dart';
import 'Level/Level8Screen.dart';
import 'Level/Level9Screen.dart';
import 'Level/Level10Screen.dart';
import 'components/AudioManager.dart';
import 'components/MusicToggleButton.dart';

class GameCardScreen extends StatefulWidget {
  const GameCardScreen({super.key});

  @override
  State<GameCardScreen> createState() => _GameCardScreenState();
}

class _GameCardScreenState extends State<GameCardScreen> {
  int? level1HighScore;
  int? level2HighScore;
  int? level3HighScore;
  int? level4HighScore;
  int? level5HighScore;
  int? level6HighScore;
  int? level7HighScore;
  int? level8HighScore;
  int? level9HighScore;
  int? level10HighScore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadHighScores(); // Reload high scores when the widget becomes visible again
  }

  // refreshHighScores
  void refreshHighScores() {
    setState(() {
      _loadHighScores(); // This will reload the high scores from SharedPreferences
    });
  }

  // Function to load high scores from SharedPreferences
  Future<void> _loadHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    level1HighScore = prefs.getInt('level1HighScore');
    level2HighScore = prefs.getInt('level2HighScore');
    level3HighScore = prefs.getInt('level3HighScore');
    level4HighScore = prefs.getInt('level4HighScore');
    level5HighScore = prefs.getInt('level5HighScore');
    level6HighScore = prefs.getInt('level6HighScore');
    level7HighScore = prefs.getInt('level7HighScore');
    level8HighScore = prefs.getInt('level8HighScore');
    level9HighScore = prefs.getInt('level9HighScore');
    level10HighScore = prefs.getInt('level10HighScore');
  }

  // Function to reset high score for all levels
  Future<void> resetHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('level1HighScore');
    prefs.remove('level2HighScore');
    prefs.remove('level3HighScore');
    prefs.remove('level4HighScore');
    prefs.remove('level5HighScore');
    prefs.remove('level6HighScore');
    prefs.remove('level7HighScore');
    prefs.remove('level8HighScore');
    prefs.remove('level9HighScore');
    prefs.remove('level10HighScore');

    // Set levelHighScore variables to null
    setState(() {
      level1HighScore = null;
      level2HighScore = null;
      level3HighScore = null;
      level4HighScore = null;
      level5HighScore = null;
      level6HighScore = null;
      level7HighScore = null;
      level8HighScore = null;
      level9HighScore = null;
      level10HighScore = null;
    });
    _loadHighScores(); // Reload high scores after reset
  }

  @override
  void initState() {
    super.initState();
    _loadHighScores();
    AudioManager.init(); // Initialize music when the app starts
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource(
        'sounds/button_click.mp3')); // Adjust the path to your sound file
  }

  // Function to show the exit confirmation dialog
  Future<void> _showExitConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit Game'),
          content: const Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
              onPressed: () {
                _playSound(); // Play sound when button is pressed
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                _playSound(); // Play sound when button is pressed
                AudioManager.stopMusic(); // Stop music when exiting
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Go back to the previous screen
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }


    void showHighScoresDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'High Scores',
            style: TextStyle(
              fontFamily: 'PixelFont', // Use a pixel art font
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Level 1: ${level1HighScore ?? 'N/A'}',
                  style: TextStyle(
                    fontFamily: 'PixelFont', // Use a pixel art font
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Level 2: ${level2HighScore ?? 'N/A'}',
                  style: TextStyle(
                    fontFamily: 'PixelFont', // Use a pixel art font
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Level 3: ${level3HighScore ?? 'N/A'}',
                  style: TextStyle(
                    fontFamily: 'PixelFont', // Use a pixel art font
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Level 4: ${level4HighScore ?? 'N/A'}',
                  style: TextStyle(
                    fontFamily: 'PixelFont', // Use a pixel art font
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Level 5: ${level5HighScore ?? 'N/A'}',
                  style: TextStyle(
                    fontFamily: 'PixelFont', // Use a pixel art font
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Level 6: ${level6HighScore ?? 'N/A'}',
                  style: TextStyle(
                    fontFamily: 'PixelFont', // Use a pixel art font
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Level 7: ${level7HighScore ?? 'N/A'}',
                  style: TextStyle(
                    fontFamily: 'PixelFont', // Use a pixel art font
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Level 8: ${level8HighScore ?? 'N/A'}',
                  style: TextStyle(
                    fontFamily: 'PixelFont', // Use a pixel art font
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Level 9: ${level9HighScore ?? 'N/A'}',
                  style: TextStyle(
                    fontFamily: 'PixelFont', // Use a pixel art font
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Level 10: ${level10HighScore ?? 'N/A'}',
                  style: TextStyle(
                    fontFamily: 'PixelFont', // Use a pixel art font
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Total: ${((level1HighScore ?? 0) + (level2HighScore ?? 0) + (level3HighScore ?? 0) + (level4HighScore ?? 0) + (level5HighScore ?? 0) + (level6HighScore ?? 0) + (level7HighScore ?? 0) + (level8HighScore ?? 0) + (level9HighScore ?? 0) + (level10HighScore ?? 0))}',
                  style: TextStyle(
                    fontFamily: 'PixelFont', // Use a pixel art font
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _playSound(); // Play sound when button is pressed
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  fontFamily: 'PixelFont', // Use a pixel art font
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/gamecard/two.gif'), // Replace with your GIF path
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Back button positioned at the top left corner
            Positioned(
              top: 16.0,
              left: 16.0,
              child: ElevatedButton(
                onPressed: () {
                  _playSound();
                  _showExitConfirmationDialog(); // Call the confirmation dialog
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: Colors
                      .transparent, // Make the button background transparent
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PixelLevelButton(
                        level: 1,
                        isUnlocked: true,
                        nextScreen: const Level1Screen(),
                        refreshHighScores: refreshHighScores,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton(
                        level: 2,
                        isUnlocked:
                            level1HighScore != null && level1HighScore! >= 6,
                        nextScreen: const Level2Screen(),
                        refreshHighScores: refreshHighScores,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton(
                        level: 3,
                        isUnlocked:
                            level2HighScore != null && level2HighScore! >= 6,
                        nextScreen: const Level3Screen(),
                        refreshHighScores: refreshHighScores,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton(
                        level: 4,
                        isUnlocked:
                            level3HighScore != null && level3HighScore! >= 7,
                        nextScreen: const Level4Screen(),
                        refreshHighScores: refreshHighScores,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton(
                        level: 5,
                        isUnlocked:
                            level4HighScore != null && level4HighScore! >= 7,
                        nextScreen: const Level5Screen(),
                        refreshHighScores: refreshHighScores,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PixelLevelButton(
                        level: 6,
                        isUnlocked:
                            level5HighScore != null && level5HighScore! >= 7,
                        nextScreen: const Level6Screen(),
                        refreshHighScores: refreshHighScores,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton(
                        level: 7,
                        isUnlocked:
                            level6HighScore != null && level6HighScore! >= 7.5,
                        nextScreen: const Level7Screen(),
                        refreshHighScores: refreshHighScores,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton(
                        level: 8,
                        isUnlocked:
                            level7HighScore != null && level7HighScore! >= 7.5,
                        nextScreen: const Level8Screen(),
                        refreshHighScores: refreshHighScores,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton(
                        level: 9,
                        isUnlocked:
                            level8HighScore != null && level8HighScore! >= 7.5,
                        nextScreen: const Level9Screen(),
                        refreshHighScores: refreshHighScores,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton(
                        level: 10,
                        isUnlocked:
                            level9HighScore != null && level9HighScore! >= 8,
                        nextScreen: const Level10Screen(),
                        refreshHighScores: refreshHighScores,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Reset High Scores Button

                      PixelGameButton(
                        height: 60,
                        width: 200,
                        text: 'Reset High Scores',
                        onTap: () {
                          _playSound(); // Play sound when button is pressed
                          resetHighScores();
                        },
                        onTapUp: () {},
                        onTapDown: () {},
                        onTapCancel: () {},
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      ),
                      const SizedBox(width: 10),

                      // View High Scores Button
                      FutureBuilder(
                        future: _loadHighScores(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return PixelGameButton(
                              height: 60,
                              width: 200,
                              text: 'View High Scores',
                              onTap: () {
                                _playSound(); // Play sound when button is pressed
                                showHighScoresDialog(context);
                              },
                              onTapUp: () {},
                              onTapDown: () {},
                              onTapCancel: () {},
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                            );
                          } else {
                            return const CircularProgressIndicator(); // Show a loading indicator
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Music Toggle Button
                  MusicToggleButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
