import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class LevelButton extends StatefulWidget {
  final int level;
  final bool isUnlocked;
  final Widget nextScreen;
  final Function refreshHighScores;

  const LevelButton({
    required this.level,
    required this.isUnlocked,
    required this.nextScreen,
    required this.refreshHighScores,
    Key? key,
  }) : super(key: key);

  @override
  _LevelButtonState createState() => _LevelButtonState();
}

class _LevelButtonState extends State<LevelButton> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _playSound() async {
    await _audioPlayer.play(AssetSource('sounds/button_click.mp3')); // Adjust the path to your sound file
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Add rounded corners
        ),
        elevation: 5, // Add elevation for shadow
        shadowColor: Color.fromARGB(255, 232, 205, 152).withOpacity(0.5), // Set shadow color
      ),
      onPressed: widget.isUnlocked
          ? () {
              _playSound(); // Play sound when button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widget.nextScreen),
              ).then((_) => widget.refreshHighScores()); // Call refreshHighScores after the screen is popped
            }
          : null, // Disable button if not unlocked
      child: Text('${widget.level}'),
    );
  }
}