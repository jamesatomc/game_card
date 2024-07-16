import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Level/Level1Screen.dart';
import 'Level/Level2Screen.dart';
import 'Level/Level3Screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int? level1HighScore;
  int? level2HighScore;
  int? level3HighScore;

  // Function to load high scores from SharedPreferences
  Future<void> _loadHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    level1HighScore = prefs.getInt('level1HighScore');
    level2HighScore = prefs.getInt('level2HighScore');
    level3HighScore = prefs.getInt('level3HighScore');
  }

  // Function to reset high score for all levels
  Future<void> resetHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('level1HighScore');
    prefs.remove('level2HighScore');
    prefs.remove('level3HighScore');
    _loadHighScores(); // Reload high scores after reset
  }

  @override
  void initState() {
    super.initState();
    _loadHighScores();
  
  }

  void refreshScores() {
    // This is where you would fetch or recalculate your scores
    // For demonstration, let's just simulate changing the scores
    setState(() {
      level1HighScore = (level1HighScore ?? 0) + 1; // Example update
      level2HighScore = (level2HighScore ?? 0) + 2; // Example update
      level3HighScore = (level3HighScore ?? 0) + 3; // Example update
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  child: const Text('1'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LevelOneScreen()),
                    );
                  },
                ),
                const SizedBox(width: 10),
                // Level Two Button with Unlock Logic
                OutlinedButton(
                  child: const Text('2'),
                  onPressed: level1HighScore != null && level1HighScore! >= 6
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LevelTwoScreen()),
                          );
                        }
                      : null, // Disable button if Level 1 high score is not met
                ),
                const SizedBox(width: 10),
                // Level Three Button with Unlock Logic
                OutlinedButton(
                  child: const Text('3'),
                  onPressed: level2HighScore != null && level2HighScore! >= 6
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LevelThreeScreen()),
                          );
                        }
                      : null, // Disable button if Level 2 high score is not met
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  child: const Text('6'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LevelOneScreen()),
                    );
                  },
                ),
                const SizedBox(width: 10),
                // Level Two Button with Unlock Logic
                OutlinedButton(
                  child: const Text('7'),
                  onPressed: level1HighScore != null && level1HighScore! >= 6
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LevelTwoScreen()),
                          );
                        }
                      : null, // Disable button if Level 1 high score is not met
                ),
                const SizedBox(width: 10),
                // Level Three Button with Unlock Logic
                OutlinedButton(
                  child: const Text('8'),
                  onPressed: level2HighScore != null && level2HighScore! >= 6
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LevelThreeScreen()),
                          );
                        }
                      : null, // Disable button if Level 2 high score is not met
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red, // Set the background color to red
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
                FutureBuilder(
                  future: _loadHighScores(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ElevatedButton(
                        child: const Row(
                          children: [
                            Icon(Icons.leaderboard),
                            SizedBox(width: 10),
                            Text('View High Scores'),
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
                                      const SizedBox(height: 10),
                                      Text(
                                          'Total: ${((level1HighScore ?? 0) + (level2HighScore ?? 0) + (level3HighScore ?? 0))}'),
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
            // Modify MenuScreen to include a toggle button for music
// Add a button in the build method:
ElevatedButton(
  onPressed: () {
    AudioManager.toggleMusic();
    setState(() {}); // Update the UI based on music state change
  },
  child: Text(AudioManager._isPlaying ? 'Pause Music' : 'Play Music'),
)
          ],
        ),
      ),
    );
  }
}


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