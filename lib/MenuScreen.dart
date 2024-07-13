import 'package:flutter/material.dart';
import 'package:flutter_cardgame/Level/Level1Screen.dart';
import 'package:flutter_cardgame/Level/Level2Screen.dart';
import 'package:flutter_cardgame/Level/Level3Screen.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  // Function to reset high score
  Future<void> resetHighScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('highScore'); // Remove high score from storage
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
              child: const Text('Level Two'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LevelThreeScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
