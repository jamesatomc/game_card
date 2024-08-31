import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cardgame/game1/GameCard.dart';
import 'package:flutter_cardgame/game2/GmaeJump.dart';

import 'game_button.dart';

class ManuGame extends StatefulWidget {
  final String username;

  const ManuGame({Key? key, required this.username}) : super(key: key);

  @override
  _ManuGameState createState() => _ManuGameState();
}

class _ManuGameState extends State<ManuGame> {
  @override
  void initState() {
    super.initState();
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource(
        'sounds/button_click.mp3')); // Adjust the path to your sound file
  }

  static const double _shadowHeight1 = 4;
  double _position1 = 4;

  static const double _shadowHeight2 = 4;
  double _position2 = 4;

  @override
  Widget build(BuildContext context) {
    const double _height = 64 - _shadowHeight1;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/gamecard/one.gif'),
                fit: BoxFit.cover,
              ),
              color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GameButton(
                    height: _height,
                    shadowHeight: _shadowHeight1,
                    position: _position1,
                    text: 'Game 1',
                    onTap: () {
                      _playSound();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GameCardScreen()),
                      );
                    },
                    onTapUp: () {
                      setState(() {
                        _position1 = 4;
                      });
                    },
                    onTapDown: () {
                      setState(() {
                        _position1 = 0;
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        _position1 = 4;
                      });
                    },
                    backgroundColor: Colors.black,
                    animatedColor: Colors.blue,
                  ),
                  GameButton(
                    height: _height,
                    shadowHeight: _shadowHeight2,
                    position: _position2,
                    text: 'Game 2',
                    onTap: () {
                      _playSound();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GmaeJump()),
                      );
                    },
                    onTapUp: () {
                      setState(() {
                        _position2 = 4;
                      });
                    },
                    onTapDown: () {
                      setState(() {
                        _position2 = 0;
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        _position2 = 4;
                      });
                    },
                    backgroundColor: Colors.black,
                    animatedColor: const Color.fromARGB(255, 41, 45, 49),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Text(
              'Player: ${widget.username}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}