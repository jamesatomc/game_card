import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cardgame/game1/GameCard.dart';
import 'package:flutter_cardgame/game2/GmaeJump.dart';

class ManuGame extends StatefulWidget {
  // ignore: use_super_parameters
  const ManuGame({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
      body: Container(
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
              SizedBox(
                height: 90,
                width:
                    260, // Makes the button take the full width of its parent
                child: GestureDetector(
                  onTap: () {
                    _playSound();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GameCardScreen()),
                    );
                  },
                  onTapUp: (_) {
                    setState(() {
                      _position1 = 4;
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      _position1 = 0;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      _position1 = 4;
                    });
                  },
                  child: Container(
                    height: _height + _shadowHeight1,
                    width: 200,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: _height,
                            width: 200,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          curve: Curves.easeIn,
                          bottom: _position1,
                          duration: Duration(milliseconds: 70),
                          child: Container(
                            height: _height,
                            width: 200,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Game 1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 16),
              SizedBox(
                height: 90,
                width:
                    260, // Makes the button take the full width of its parent
                child: GestureDetector(
                  onTap: () {
                    _playSound();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GmaeJump()),
                    );
                  },
                  onTapUp: (_) {
                    setState(() {
                      _position2 = 4;
                    });
                  },
                  onTapDown: (_) {
                    setState(() {
                      _position2 = 0;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      _position2 = 4;
                    });
                  },
                  child: Container(
                    height: _height + _shadowHeight2,
                    width: 200,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: _height,
                            width: 200,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          curve: Curves.easeIn,
                          bottom: _position2,
                          duration: Duration(milliseconds: 70),
                          child: Container(
                            height: _height,
                            width: 200,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Game 2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
