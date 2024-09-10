import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'components/game_button.dart';
import 'game1/GameCard.dart';
import 'game2/GameJump.dart';

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
            image: AssetImage(
                'assets/gamecard/bg_pixel2.png'), // ใช้พื้นหลังแบบพิกเซล
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius:
                      BorderRadius.circular(10), // Add rounded corners
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
                          color: Colors.black,
                          shadows: [
                            Shadow(
                              blurRadius: 0,
                              color: Colors.white,
                              offset: Offset(4, 4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      PixelGameButton(
                        height: 60,
                        width: 200,
                        text: 'จับคู่มหาสนุก',
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
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        borderRadius: BorderRadius.circular(10) // Set rounded corners
                      ),
                      const SizedBox(height: 20),
                      PixelGameButton(
                        height: 60,
                        width: 200,
                        text: 'หนูน้อยผจญภัย',
                        onTap: () {
                          _playSound();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GameJump()),
                          );
                        },
                        onTapUp: () {},
                        onTapDown: () {},
                        onTapCancel: () {},
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        borderRadius: BorderRadius.circular(10) // Set rounded corners
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.7),
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius:
                      BorderRadius.circular(10), // Add rounded corners
                ),
                child: Text(
                  '${widget.username}',
                  style: const TextStyle(
                    // fontFamily: 'PixelFont',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
