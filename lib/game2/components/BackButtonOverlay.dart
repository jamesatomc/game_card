// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';

import '../GmaeJump.dart'; // Import FlameAudio

class BackButtonOverlay extends StatelessWidget {
  final VoidCallback onPressed;

  BackButtonOverlay({super.key, required this.onPressed});

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource(
        'sounds/button_click.mp3')); // Adjust the path to your sound file
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      child: ElevatedButton(
        onPressed: () {
          _playSound();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Exit Game'),
                content: const Text('Are you sure you want to exit?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      _playSound(); // Play sound when "No" is pressed
                      Navigator.of(context).pop(); // Close dialog
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      _playSound(); // Play sound when "Yes" is pressed
                      FlameAudio.bgm.stop(); // Stop the background music
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => GmaeJump()),
                        (route) => false,
                      ); // Navigate to GmaeJump and remove all previous routes
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(), // Make the button circular
          padding: const EdgeInsets.all(16.0), // Add padding around the button
          backgroundColor: Colors.transparent, // Make the button background transparent
        ),
        child: const Icon(
          Icons.arrow_back, // Change the text to a back arrow icon
          color: Colors.white, // Set the icon color
          size: 32.0, // Set the icon size
        ),
      ),
    );
  }
}