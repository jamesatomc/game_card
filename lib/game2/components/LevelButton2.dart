import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PixelLevelButton2 extends StatefulWidget {
  final int level;
  final bool isUnlocked;
  final Widget nextScreen;
  final VoidCallback onTapUp;
  final VoidCallback onTapDown;
  final VoidCallback onTapCancel;
  final VoidCallback onTap;

  const PixelLevelButton2({
    required this.level,
    required this.isUnlocked,
    required this.nextScreen,
    required this.onTapUp,
    required this.onTapDown,
    required this.onTapCancel,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _PixelLevelButton2State createState() => _PixelLevelButton2State();
}

class _PixelLevelButton2State extends State<PixelLevelButton2> {
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
              widget.onTap();
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
          color: widget.isUnlocked ? const Color.fromARGB(255, 245, 148, 233) : Colors.grey,
          border: Border.all(color: const Color.fromARGB(255, 223, 43, 229), width: 4),
          borderRadius: BorderRadius.circular(10), // Add rounded corners
          boxShadow: widget.isUnlocked && !_isPressed
              ? [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(4, 4),
                    blurRadius: 0,
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