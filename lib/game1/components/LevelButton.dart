import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PixelLevelButton extends StatefulWidget {
  final int level;
  final bool isUnlocked;
  final Widget nextScreen;
  final VoidCallback onTapUp;
  final VoidCallback onTapDown;
  final VoidCallback onTapCancel;

  const PixelLevelButton({
    required this.level,
    required this.isUnlocked,
    required this.nextScreen,
    required this.onTapUp,
    required this.onTapDown,
    required this.onTapCancel,
    Key? key,
  }) : super(key: key);

  @override
  _PixelLevelButtonState createState() => _PixelLevelButtonState();
}

class _PixelLevelButtonState extends State<PixelLevelButton> {
  bool _isPressed = false;

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource('sounds/button_click.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        widget.onTapDown();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTapUp();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        widget.onTapCancel();
      },
      onTap: widget.isUnlocked
          ? () {
              _playSound();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widget.nextScreen),
              );
            }
          : null,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: widget.isUnlocked ? Colors.blue : Colors.grey,
          border: Border.all(color: const Color.fromARGB(255, 163, 195, 249), width: 4),
          borderRadius: BorderRadius.circular(10), // Add rounded corners
          boxShadow: widget.isUnlocked && !_isPressed
              ? [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(4, 4),
                    blurRadius: 2,
                  )
                ]
              : [],
        ),
        child: Center(
          child: Text(
            '${widget.level}',
            style: TextStyle(
              fontFamily: 'PixelFont',
              fontSize: 32,
              color: widget.isUnlocked ? Colors.white : Colors.black54,
              shadows: widget.isUnlocked
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