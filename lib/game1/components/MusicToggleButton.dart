import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:game_somo/game1/components/AudioManager.dart';
import 'package:game_somo/components/game_button.dart';

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
    return IconButton(
      icon: Icon(isPlaying ? Icons.volume_up : Icons.volume_off),
      onPressed: () {
        _playSound(); // Play sound when button is pressed
        _toggleMusic();
      },
      color: Colors.white, // Set the icon color
      iconSize: 60, // Set the icon size
      padding: EdgeInsets.zero, // Remove padding
      constraints: BoxConstraints(
        minHeight: 60,
        minWidth: 60,
      ),
      splashColor: isPlaying ? Colors.red : Colors.blue, // Set the splash color
    );
  }
}