import 'package:flutter/material.dart';
import 'package:flutter_cardgame/manu_game.dart';

class NameInputScreen extends StatefulWidget {
  final Function(String) onSave;

  const NameInputScreen({required this.onSave});

  @override
  State<NameInputScreen> createState() => NameInputScreenState();
}

class NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your name:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: _nameController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  widget.onSave(_nameController.text);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManuGame(username: '',),
                    ),
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}