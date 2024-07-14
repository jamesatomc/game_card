import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text('Level One'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LevelOneScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Level Two'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LevelTwoScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Level Three'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LevelThreeScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text('Reset All High Scores'),
                    onPressed: resetHighScores,
                  ),
                  const SizedBox(width: 10),
                  FutureBuilder(
                    future: _loadHighScores(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ElevatedButton(
                          child: const Text('View High Scores'),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('High Scores'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Level 1: ${level1HighScore ?? 'N/A'}'),
                                      Text('Level 2: ${level2HighScore ?? 'N/A'}'),
                                      Text('Level 3: ${level3HighScore ?? 'N/A'}'),
                                      const SizedBox(height: 10),
                                      Text(
                                          'Total: ${((level1HighScore ?? 0) + (level2HighScore ?? 0) + (level3HighScore ?? 0))}'),
                                    ],
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
            ),
          ],
        ),
      ),
    );
  }
}
