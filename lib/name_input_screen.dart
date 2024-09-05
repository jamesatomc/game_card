import 'package:flutter/material.dart';
import 'package:flutter_cardgame/manu_game.dart';

import 'game_button.dart';



class NameInputScreen extends StatefulWidget {
  final Function(String) onSave;

  const NameInputScreen({required this.onSave, Key? key}) : super(key: key);

  @override
  State<NameInputScreen> createState() => NameInputScreenState();
}

class NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/gamecard/bg_pixel1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7), // Semi-transparent black
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Text(
                    "What's your name?:",
                    style: TextStyle(
                      fontFamily: 'PixelFont',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7), // Semi-transparent black
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: TextField(
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'PixelFont',
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        hintText: 'Your Name',
                        hintStyle: TextStyle(
                          fontFamily: 'PixelFont',
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                PixelGameButton(
                  height: 60,
                  width: 200,
                  text: 'OK',
                  onTap: () {
                    if (_nameController.text.isNotEmpty) {
                      widget.onSave(_nameController.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManuGame(username: _nameController.text),
                        ),
                      );
                    }
                  },
                  onTapUp: () {},
                  onTapDown: () {},
                  onTapCancel: () {},
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
