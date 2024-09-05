import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cardgame/game1/components/AudioManager.dart';
import 'package:flutter_cardgame/components/game_button.dart';

class MusicToggleButton extends StatefulWidget {
  @override
  _MusicToggleButtonState createState() => _MusicToggleButtonState();
}

class _MusicToggleButtonState extends State<MusicToggleButton> {
  bool isPlaying = AudioManager.isPlaying;

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource(
        'sounds/button_click.mp3')); // Adjust the path to your sound file
  }

  void _toggleMusic() {
    AudioManager.toggleMusic();
    setState(() {
      isPlaying = !isPlaying; // Update the state immediately
    });
  }

  @override
  Widget build(BuildContext context) {
    return PixelGameButton(
      height: 60,
      width: 60,
      text: '', // No text needed for this button
      icon: isPlaying ? Icons.play_disabled : Icons.play_arrow, // Pass IconData
      onTap: () {
        _playSound(); // Play sound when button is pressed
        _toggleMusic();
      },
      onTapUp: () {},
      onTapDown: () {},
      onTapCancel: () {},
      backgroundColor: isPlaying ? Colors.red : Colors.blue,
      textColor: Colors.white,
    );
  }
}