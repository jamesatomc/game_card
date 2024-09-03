import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cardgame/game2/Level/Jump1.dart';
import 'package:flutter_cardgame/game2/components/LevelButton2.dart';

import 'components/BackButtonOverlay.dart';

class GmaeJump extends StatefulWidget {
  const GmaeJump({Key? key}) : super(key: key);

  @override
  _GmaeJumpState createState() => _GmaeJumpState();
}

class _GmaeJumpState extends State<GmaeJump> {
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
                        nextScreen: GmaeJump(),
                        onTapUp: () {},
                        onTapDown: () {},
                        onTapCancel: () {},
                      ),
                      const SizedBox(width: 10),
                      PixelLevelButton2(
                        level: 2,
                        isUnlocked:
                            level1CoinScore != null && level1CoinScore! >= 6,
                        nextScreen: GmaeJump(),
                        onTapUp: () {},
                        onTapDown: () {},
                        onTapCancel: () {},
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add rounded corners
                          ),
                          elevation: 5, // Add elevation for shadow
                          shadowColor: Color.fromARGB(255, 232, 205, 152)
                              .withOpacity(0.5), // Set shadow color
                        ),
                        onPressed:
                            level3CoinScore != null && level3CoinScore! >= 6
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GameWidget(
                                          game: Jump1(),
                                          overlayBuilderMap: {
                                            'BackButton': (context, game) =>
                                                BackButtonOverlay(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                        child: const Text('3'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add rounded corners
                          ),
                          elevation: 5, // Add elevation for shadow
                          shadowColor: Color.fromARGB(255, 232, 205, 152)
                              .withOpacity(0.5), // Set shadow color
                        ),
                        onPressed:
                             () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GameWidget(
                                          game: Jump1(),
                                          overlayBuilderMap: {
                                            'BackButton': (context, game) =>
                                                BackButtonOverlay(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                          },
                                        ),
                                      ),
                                    );
                                  },
                        child: const Text('4'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add rounded corners
                          ),
                          elevation: 5, // Add elevation for shadow
                          shadowColor: Color.fromARGB(255, 232, 205, 152)
                              .withOpacity(0.5), // Set shadow color
                        ),
                        onPressed:
                            level5CoinScore != null && level5CoinScore! >= 6
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GameWidget(
                                          game: Jump1(),
                                          overlayBuilderMap: {
                                            'BackButton': (context, game) =>
                                                BackButtonOverlay(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                        child: const Text('5'),
                      ),
                    ],
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
