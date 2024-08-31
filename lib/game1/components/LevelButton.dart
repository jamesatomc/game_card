import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PixelLevelButton extends StatelessWidget {
  final int level;
  final bool isUnlocked;
  final Widget nextScreen;
  final Function refreshHighScores;

  const PixelLevelButton({
    required this.level,
    required this.isUnlocked,
    required this.nextScreen,
    required this.refreshHighScores,
    Key? key,
  }) : super(key: key);

  void _playSound() async {
    final player = AudioPlayer();
    await player.play(AssetSource('sounds/button_click.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isUnlocked
          ? () {
              _playSound();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => nextScreen),
              ).then((_) => refreshHighScores());
            }
          : null,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: isUnlocked ? Colors.blue : Colors.grey,
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(4, 4),
                    blurRadius: 0,
                  )
                ]
              : [],
        ),
        child: Center(
          child: Text(
            '$level',
            style: TextStyle(
              fontFamily: 'PixelFont',
              fontSize: 32,
              color: isUnlocked ? Colors.white : Colors.black54,
              shadows: isUnlocked
                  ? [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 2),
                        blurRadius: 0,
                      )
                    ]
                  : [],
            ),
          ),
        ),
      ),
    );
  }
}
