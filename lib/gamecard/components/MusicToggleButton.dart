
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cardgame/gamecard/components/AudioManager.dart';

class MusicToggleButton extends StatefulWidget {
  @override
  _MusicToggleButtonState createState() => _MusicToggleButtonState();
}

class _MusicToggleButtonState extends State<MusicToggleButton> {
  bool isPlaying = AudioManager.isPlaying;

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource('sounds/button_click.mp3')); // Adjust the path to your sound file
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
      onPressed: () {
        _playSound();
        _toggleMusic();
      },
      icon: Icon(isPlaying ? Icons.play_disabled : Icons.play_arrow),
    );
  }
}