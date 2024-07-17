import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import all level screens
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

class AudioManager {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static bool _isPlaying = false;

  static Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isPlaying = prefs.getBool('musicEnabled') ?? true; // Default to true
    if (_isPlaying) {
      playMusic();
    }
  }

  static void playMusic() async {
    await _audioPlayer.play(AssetSource('audio/lofi.mp3'), volume: 0.5);
    _isPlaying = true;
  }

  static void pauseMusic() async {
    await _audioPlayer.pause();
    _isPlaying = false;
  }

  static void toggleMusic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_isPlaying) {
      pauseMusic();
    } else {
      playMusic();
    }
    prefs.setBool('musicEnabled', _isPlaying);
  }
}

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

  // Function to load high scores from SharedPreferences
  Future<void> _loadHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    level1HighScore = prefs.getInt('level1HighScore');
    level2HighScore = prefs.getInt('level2HighScore');
    level3HighScore = prefs.getInt('level3HighScore');
    level4HighScore = prefs.getInt('level1HighScore');
    level5HighScore = prefs.getInt('level2HighScore');
    level6HighScore = prefs.getInt('level3HighScore');
    level7HighScore = prefs.getInt('level3HighScore');
    level8HighScore = prefs.getInt('level1HighScore');
    level9HighScore = prefs.getInt('level2HighScore');
    level10HighScore = prefs.getInt('level3HighScore');
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
    _loadHighScores(); // Reload high scores after reset
  }

  @override
  void initState() {
    super.initState();
    _loadHighScores();
    AudioManager.init(); // Initialize music when the app starts
  }

  void refreshScores() {
    // This is where you would fetch or recalculate your scores
    // For demonstration, let's just simulate changing the scores
    setState(() {
      level1HighScore = (level1HighScore ?? 0) + 1; // Example update
      level2HighScore = (level2HighScore ?? 0) + 2; // Example update
      level3HighScore = (level3HighScore ?? 0) + 3; // Example update
      level4HighScore = (level4HighScore ?? 0) + 4; // Example update
      level5HighScore = (level5HighScore ?? 0) + 5; // Example update
      level6HighScore = (level6HighScore ?? 0) + 6; // Example update
      level7HighScore = (level7HighScore ?? 0) + 7; // Example update
      level8HighScore = (level8HighScore ?? 0) + 8; // Example update
      level9HighScore = (level9HighScore ?? 0) + 9; // Example update
      level10HighScore = (level10HighScore ?? 0) + 10; // Example update
    });
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
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Card'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:
              _showExitConfirmationDialog, // Show the dialog when back button is pressed
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Level 1 Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    elevation: 5, // Add elevation for shadow
                    shadowColor:
                        Colors.grey.withOpacity(0.5), // Set shadow color
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Level1Screen()),
                    );
                  },
                  child: const Text('1'),
                ),
                const SizedBox(width: 10),
                // Level 2 Button
                // Level Two Button with Unlock Logic
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    elevation: 5, // Add elevation for shadow
                    shadowColor:
                        Colors.grey.withOpacity(0.5), // Set shadow color
                  ),
                  onPressed: level1HighScore != null && level1HighScore! >= 6
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Level2Screen()),
                          );
                        }
                      : null, // Disable button if Level 1 high score is not met
                  child: const Text('2'),
                ),
                const SizedBox(width: 10),
                // Level 3 Button
                // Level Three Button with Unlock Logic
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    elevation: 5, // Add elevation for shadow
                    shadowColor:
                        Colors.grey.withOpacity(0.5), // Set shadow color
                  ),
                  onPressed: level2HighScore != null && level2HighScore! >= 6
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Level3Screen()),
                          );
                        }
                      : null, // Disable button if Level 2 high score is not met
                  child: const Text('3'),
                ),
                const SizedBox(width: 10),
                // Level 4 Button
                // Level Four Button with Unlock Logic
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    elevation: 5, // Add elevation for shadow
                    shadowColor:
                        Colors.grey.withOpacity(0.5), // Set shadow color
                  ),
                  onPressed: level1HighScore != null && level1HighScore! >= 6
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Level4Screen()),
                          );
                        }
                      : null, // Disable button if Level 1 high score is not met
                  child: const Text('4'),
                ),
                const SizedBox(width: 10),
                // Level 5 Button
                // Level Five Button with Unlock Logic
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    elevation: 5, // Add elevation for shadow
                    shadowColor:
                        Colors.grey.withOpacity(0.5), // Set shadow color
                  ),
                  onPressed: level2HighScore != null && level2HighScore! >= 6
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Level5Screen()),
                          );
                        }
                      : null, // Disable button if Level 2 high score is not met
                  child: const Text('5'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Level Six Button
                // Level Six Button with Unlock Logic
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    elevation: 5, // Add elevation for shadow
                    shadowColor:
                        Colors.grey.withOpacity(0.5), // Set shadow color
                  ),
                  onPressed: level1HighScore != null && level1HighScore! >= 6
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Level6Screen()),
                          );
                        }
                      : null, // Disable button if Level 7 high score is not met
                  child: const Text('6'),
                ),
                const SizedBox(width: 10),
                // Level Seven Button
                // Level Seven Button with Unlock Logic
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    elevation: 5, // Add elevation for shadow
                    shadowColor:
                        Colors.grey.withOpacity(0.5), // Set shadow color
                  ),
                  onPressed: level1HighScore != null && level1HighScore! >= 6
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Level7Screen()),
                          );
                        }
                      : null, // Disable button if Level 8 high score is not met
                  child: const Text('7'),
                ),
                const SizedBox(width: 10),
                // Level Eight Button with Unlock Logic
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    elevation: 5, // Add elevation for shadow
                    shadowColor:
                        Colors.grey.withOpacity(0.5), // Set shadow color
                  ),
                  onPressed: level2HighScore != null && level2HighScore! >= 6
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Level8Screen()),
                          );
                        }
                      : null, // Disable button if Level 9 high score is not met
                  child: const Text('8'),
                ),
                const SizedBox(width: 10),
                // Level Nine Button
                // Level Nine Button with Unlock Logic
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    elevation: 5, // Add elevation for shadow
                    shadowColor:
                        Colors.grey.withOpacity(0.5), // Set shadow color
                  ),
                  onPressed: level2HighScore != null && level2HighScore! >= 6
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Level9Screen()),
                          );
                        }
                      : null, // Disable button if Level 10 high score is not met
                  child: const Text('9'),
                ),
                const SizedBox(width: 10),
                // Level Ten Button with Unlock Logic
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    elevation: 5, // Add elevation for shadow
                    shadowColor:
                        Colors.grey.withOpacity(0.5), // Set shadow color
                  ),
                  onPressed: level2HighScore != null && level2HighScore! >= 6
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Level10Screen()),
                          );
                        }
                      : null, // Disable button if Level 10 high score is not met
                  child: const Text('10'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Reset High Scores Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Add rounded corners
                    ),
                    elevation: 5, // Add elevation for shadow
                    shadowColor:
                        Colors.grey.withOpacity(0.5), // Set shadow color
                  ),
                  onPressed: resetHighScores,
                  child: const Row(
                    children: [
                      Icon(Icons.refresh, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Reset High Scores',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // View High Scores Button
                FutureBuilder(
                  future: _loadHighScores(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 74, 201, 55),
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add rounded corners
                          ),
                          elevation: 5, // Add elevation for shadow
                          shadowColor:
                              Colors.grey.withOpacity(0.5), // Set shadow color
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.leaderboard, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'View High Scores',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('High Scores'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Level 1: ${level1HighScore ?? 'N/A'}'),
                                      Text(
                                          'Level 2: ${level2HighScore ?? 'N/A'}'),
                                      Text(
                                          'Level 3: ${level3HighScore ?? 'N/A'}'),
                                      Text(
                                          'Level 4: ${level4HighScore ?? 'N/A'}'),
                                      Text(
                                          'Level 5: ${level5HighScore ?? 'N/A'}'),
                                      Text(
                                          'Level 6: ${level6HighScore ?? 'N/A'}'),
                                      Text(
                                          'Level 7: ${level7HighScore ?? 'N/A'}'),
                                      Text(
                                          'Level 8: ${level8HighScore ?? 'N/A'}'),
                                      Text(
                                          'Level 9: ${level9HighScore ?? 'N/A'}'),
                                      Text(
                                          'Level 10: ${level10HighScore ?? 'N/A'}'),
                                      const SizedBox(height: 10),
                                      Text('Total: ${(
                                        (level1HighScore ?? 0) +
                                            (level2HighScore ?? 0) +
                                            (level3HighScore ?? 0) +
                                            (level4HighScore ?? 0) +
                                            (level5HighScore ?? 0) +
                                            (level6HighScore ?? 0) +
                                            (level7HighScore ?? 0) +
                                            (level8HighScore ?? 0) +
                                            (level9HighScore ?? 0) +
                                            (level10HighScore ?? 0),
                                      )}'),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: refreshScores,
                                        child: const Text('Refresh Scores'),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return const CircularProgressIndicator(); // Show a loading indicator
                    }
                  },
                ),
              ],
            ),
            const SizedBox(width: 10),
            // Music Toggle Button
            IconButton(
              onPressed: () {
                AudioManager.toggleMusic();
                setState(() {}); // Update the UI based on music state change
              },
              icon: Icon(AudioManager._isPlaying
                  ? Icons.play_disabled
                  : Icons.play_arrow),
            )
          ],
        ),
      ),
    );
  }
}
