import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_cardgame/game2/components/LevelButton2.dart';
import '../game_button.dart';
import 'Quiz/quiz1.dart';
import 'components/HowToPlay.dart';

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
                        nextScreen: GameJump(),
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
                        nextScreen: GameJump(),
                        onTapUp: () {},
                        onTapDown: () {},
                        onTapCancel: () {},
                        onTap: _stopBackgroundMusic,
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton2(
                        level: 4,
                        isUnlocked:
                            level2CoinScore != null && level2CoinScore! >= 10,
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
                  PixelGameButton(
                    height: 60,
                    width: 200,
                    text: 'How to Play',
                    onTap: () {
                      _stopBackgroundMusic();
                      // Navigate to the How to Play screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Howtoplay2(),
                        ),
                      );
                    },
                    onTapUp: () {},
                    onTapDown: () {},
                    onTapCancel: () {},
                    backgroundColor: Colors.greenAccent,
                    textColor: Colors.black,
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
