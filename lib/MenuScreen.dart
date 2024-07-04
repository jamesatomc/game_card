// Define MenuScreen widget
import 'package:flutter/material.dart';
import 'package:flutter_cardgame/Level/LevelOneScreen.dart';
import 'package:flutter_cardgame/Level/LevelTwoScreen.dart';

class MenuScreen extends StatelessWidget {

  const MenuScreen({super.key});

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
            // Add more buttons for additional levels here
          ],
        ),
      ),
    );
  }
}