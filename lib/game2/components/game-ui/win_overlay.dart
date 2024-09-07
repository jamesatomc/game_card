import 'package:flutter/material.dart';

class WinOverlay extends StatelessWidget {
  final VoidCallback onNextQuiz;

  const WinOverlay({required this.onNextQuiz, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent, // Set the background color
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Congratulations!',
              style: TextStyle(fontSize: 30, color: Colors.green),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onNextQuiz,
              child: Text('Go to Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}