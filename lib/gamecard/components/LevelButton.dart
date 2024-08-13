import 'package:flutter/material.dart';

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
        shadowColor: Colors.grey.withOpacity(0.5), // Set shadow color
      ),
      onPressed: widget.isUnlocked
          ? () {
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