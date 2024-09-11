import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/game_button.dart';

import 'Quiz/quiz1.dart';
import 'Quiz/quiz2.dart';
import 'Quiz/quiz3.dart';
import 'components/HowToPlay.dart';
import 'components/LevelButton2.dart';

class GameJump extends StatefulWidget {
  const GameJump({Key? key}) : super(key: key);

  @override
  _GameJumpState createState() => _GameJumpState();
}

class _GameJumpState extends State<GameJump> {
  int? level1CoinScore;
  int? level2CoinScore;
  int? level3CoinScore;
  int? level4CoinScore;
  int? level5CoinScore;
  int? level6CoinScore;
  int? level7CoinScore;
  int? level8CoinScore;
  int? level9CoinScore;
  int? level10CoinScore;

  late AudioPlayer _audioPlayer;
  bool _isMusicPlaying = false; // Flag to track music playback

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playBackgroundMusic();
    _loadCoinScores(); // Load coin scores from SharedPreferences
  }

  Future<void> _playBackgroundMusic() async {
    if (!_isMusicPlaying) {
      // Only play if not already playing
      try {
        await _audioPlayer.play(AssetSource('audio/lofi.mp3'), volume: 0.5);
        _isMusicPlaying = true;
        print('Background music started');
      } catch (e) {
        print('Error playing background music: $e');
      }
    }
  }

  void _stopBackgroundMusic() {
    if (_isMusicPlaying) {
      _audioPlayer.stop();
      _isMusicPlaying = false;
    }
  }

  Future<void> _loadCoinScores() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      level1CoinScore = prefs.getInt('level1CoinScore') ?? 0;
      level2CoinScore = prefs.getInt('level2CoinScore') ?? 0;
      level3CoinScore = prefs.getInt('level3CoinScore') ?? 0;
      level4CoinScore = prefs.getInt('level4CoinScore') ?? 0;
      level5CoinScore = prefs.getInt('level5CoinScore') ?? 0;
      level6CoinScore = prefs.getInt('level6CoinScore') ?? 0;
      level7CoinScore = prefs.getInt('level7CoinScore') ?? 0;
      level8CoinScore = prefs.getInt('level8CoinScore') ?? 0;
      level9CoinScore = prefs.getInt('level9CoinScore') ?? 0;
      level10CoinScore = prefs.getInt('level10CoinScore') ?? 0;
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

                _stopBackgroundMusic(); // Stop the background music
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bg2.png'), // Replace with your GIF path
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
                      PixelLevelButton2(
                        level: 1,
                        isUnlocked: true,
                        nextScreen: Quiz1(
                            onResumeMusic:
                                _playBackgroundMusic), // Pass the function
                        onTapUp: () {},
                        onTapDown: () {},
                        onTapCancel: () {},
                        onTap: _stopBackgroundMusic,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton2(
                        level: 2,
                        isUnlocked:
                            level1CoinScore != null && level1CoinScore! >= 10,
                        nextScreen: Quiz2(onResumeMusic: _playBackgroundMusic),
                        onTapUp: () {},
                        onTapDown: () {},
                        onTapCancel: () {},
                        onTap: _stopBackgroundMusic,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton2(
                        level: 3,
                        isUnlocked:
                            level2CoinScore != null && level2CoinScore! >= 10,
                        nextScreen: Quiz3(onResumeMusic: _playBackgroundMusic),
                        onTapUp: () {},
                        onTapDown: () {},
                        onTapCancel: () {},
                        onTap: _stopBackgroundMusic,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton2(
                        level: 4,
                        isUnlocked:
                            level3CoinScore != null && level3CoinScore! >= 10,
                        nextScreen: GameJump(),
                        onTapUp: () {},
                        onTapDown: () {},
                        onTapCancel: () {},
                        onTap: _stopBackgroundMusic,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton2(
                        level: 5,
                        isUnlocked:
                            level4CoinScore != null && level4CoinScore! >= 10,
                        nextScreen: GameJump(),
                        onTapUp: () {},
                        onTapDown: () {},
                        onTapCancel: () {},
                        onTap: _stopBackgroundMusic,
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PixelLevelButton2(
                        level: 6,
                        isUnlocked: true,
                        nextScreen: Quiz1(
                            onResumeMusic:
                                _playBackgroundMusic), // Pass the function
                        onTapUp: () {},
                        onTapDown: () {},
                        onTapCancel: () {},
                        onTap: _stopBackgroundMusic,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton2(
                        level: 7,
                        isUnlocked:
                            level1CoinScore != null && level1CoinScore! >= 10,
                        nextScreen: Quiz2(onResumeMusic: _playBackgroundMusic),
                        onTapUp: () {},
                        onTapDown: () {},
                        onTapCancel: () {},
                        onTap: _stopBackgroundMusic,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton2(
                        level: 8,
                        isUnlocked:
                            level2CoinScore != null && level2CoinScore! >= 10,
                        nextScreen: Quiz3(onResumeMusic: _playBackgroundMusic),
                        onTapUp: () {},
                        onTapDown: () {},
                        onTapCancel: () {},
                        onTap: _stopBackgroundMusic,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton2(
                        level: 9,
                        isUnlocked:
                            level3CoinScore != null && level3CoinScore! >= 10,
                        nextScreen: GameJump(),
                        onTapUp: () {},
                        onTapDown: () {},
                        onTapCancel: () {},
                        onTap: _stopBackgroundMusic,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton2(
                        level: 10,
                        isUnlocked:
                            level4CoinScore != null && level4CoinScore! >= 10,
                        nextScreen: GameJump(),
                        onTapUp: () {},
                        onTapDown: () {},
                        onTapCancel: () {},
                        onTap: _stopBackgroundMusic,
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  // PixelGameButton(
                  //   height: 60,
                  //   width: 200,
                  //   text: 'How to Play',
                  //   onTap: () {
                  //     _stopBackgroundMusic();
                  //     // Navigate to the How to Play screen
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => Howtoplay2(
                  //             onResumeMusic:
                  //                 _playBackgroundMusic), // Pass the function
                  //       ),
                  //     );
                  //   },
                  //   onTapUp: () {},
                  //   onTapDown: () {},
                  //   onTapCancel: () {},
                  //   backgroundColor: Colors.greenAccent,
                  //   textColor: Colors.black,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
