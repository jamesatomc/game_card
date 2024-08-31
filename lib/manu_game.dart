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
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource('sounds/button_click.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pixel_background.png'), // ใช้พื้นหลังแบบพิกเซล
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'GAME MENU',
                style: TextStyle(
                  fontFamily: 'PixelFont',
                  fontSize: 48,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 0,
                      color: Colors.black,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              PixelGameButton(
                height: 60,
                width: 200,
                text: 'GAME 1',
                onTap: () {
                  _playSound();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GameCardScreen()),
                  );
                },
                onTapUp: () {},
                onTapDown: () {},
                onTapCancel: () {},
                backgroundColor: Colors.red,
                textColor: Colors.yellow,
              ),
              const SizedBox(height: 20),
              PixelGameButton(
                height: 60,
                width: 200,
                text: 'GAME 2',
                onTap: () {
                  _playSound();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GmaeJump()),
                  );
                },
                onTapUp: () {},
                onTapDown: () {},
                onTapCancel: () {},
                backgroundColor: Colors.blue,
                textColor: Colors.white,
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Text(
                  'PLAYER: ${widget.username}',
                  style: const TextStyle(
                    // fontFamily: 'PixelFont',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}