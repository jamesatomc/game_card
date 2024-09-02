import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cardgame/game1/components/info_card.dart';
import 'package:flutter_cardgame/game1/utils/game_utils2.dart';
import 'package:flutter_cardgame/game_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart'; // Import the audioplayers package

import 'Level3Screen.dart';

class Level2Screen extends StatefulWidget {
  const Level2Screen({super.key});

  @override
  _Level2ScreenState createState() => _Level2ScreenState();
}

class _Level2ScreenState extends State<Level2Screen> {
  //setting text style
  bool hideTest = false;
  final Game _game = Game();
  final AudioPlayer _audioPlayer =
      AudioPlayer(); // Create an instance of AudioPlayer

  //game stats
  int tries = 0;
  double score = 0; // เปลี่ยน score เป็น double เพื่อเก็บคะแนนทศนิยม
  int level2HighScore = 0; // เพิ่มตัวแปรสำหรับเก็บ high score ของ Level 2

  int matchedPairs = 0;
  late Timer _timer;
  int _timeLeft = 80; // 1:20 นาที = 80 วินาที

  List<int> revealedCards = [];
  List<int> matchedCardIndices =
      []; // เพิ่ม list สำหรับเก็บ index ของไพ่ที่จับคู่กันแล้ว

  bool _gameStarted = false; // Flag to track if the game has started

  @override
  void initState() {
    super.initState();
    _game.initGame();
    revealedCards.clear();
    matchedCardIndices.clear(); // เริ่มต้น list ของไพ่ที่จับคู่กันแล้ว
    _loadHighScore(); // เรียกใช้ฟังก์ชัน _loadHighScore() ใน initState()

    // Reveal all cards initially
    setState(() {
      _game.gameImg = _game.cards_list;
    });
  }

  // ฟังก์ชันสำหรับโหลด high score จาก SharedPreferences
  Future<void> _loadHighScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      level2HighScore = prefs.getInt('level2HighScore') ??
          0; // โหลด high score จาก SharedPreferences
    });
  }

  // ฟังก์ชันสำหรับบันทึก high score ลง SharedPreferences
  Future<void> _saveHighScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (score > level2HighScore) {
      prefs.setInt('level2HighScore',
          score.toInt()); // บันทึก high score ลง SharedPreferences
      setState(() {
        level2HighScore =
            score.toInt(); // บันทึก high score ลงตัวแปร level2HighScore
      });
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_timeLeft == 0) {
          setState(() {
            timer.cancel();
            showTimeUpDialog();
          });
        } else {
          setState(() {
            _timeLeft--;
            if (_timeLeft <= 10) {
              playTimeRunningOutSound(); // Play sound when time is running out
            }
          });
        }
      },
    );
  }

  void showLevelCompleteDialog() {
    playLevelCompleteSound(); // Play sound when level is completed
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Level Complete!'),
          content: Text('Congratulations! You\'ve completed Level 2.'),
          actions: <Widget>[
            TextButton(
              child: Text('Play Again'),
              onPressed: () {
                Navigator.of(context).pop(); // ปิด AlertDialog
                restartLevel(); // เริ่มเล่นใหม่
              },
            ),
            TextButton(
              child: Text('Next Leve 3'),
              onPressed: () {
                if (score >= 6) {
                  // เพิ่มเงื่อนไขตรวจสอบคะแนน
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Level3Screen()),
                  );
                } else {
                  // แสดงข้อความแจ้งเตือนว่าคะแนนไม่ถึง
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'You need at least 6 points to proceed to Level 3.')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Time\'s Up!'),
          content: Text('Sorry, you ran out of time.'),
          actions: <Widget>[
            TextButton(
              child: Text('Try Again'),
              onPressed: () {
                Navigator.of(context).pop();
                restartLevel();
              },
            ),
          ],
        );
      },
    );
  }

  void restartLevel() {
    setState(() {
      _game.initGame();
      tries = 0;
      score = 0;
      matchedPairs = 0;
      _timeLeft = 80;
      revealedCards.clear();
      matchedCardIndices.clear(); // เริ่มต้น list ของไพ่ที่จับคู่กันแล้ว
      _gameStarted = false; // Reset game started flag
      _game.gameImg = _game.cards_list; // Reveal all cards again
    });
  }

  // Add this state variable to track mismatched card indices
  List<int> mismatchedCardIndices = [];

  void checkMatch() {
    if (_game.matchCheck.length == 2) {
      int firstIndex = _game.matchCheck[0].keys.first;
      int secondIndex = _game.matchCheck[1].keys.first;

      if (_game.checkMatch(firstIndex, secondIndex)) {
        setState(() {
          score += 2.5; // เพิ่มคะแนน 2.5 คะแนนเมื่อจับคู่ถูก
          matchedPairs++;
          matchedCardIndices.addAll(
              [firstIndex, secondIndex]); // เพิ่ม index ของไพ่ที่จับคู่กันแล้ว
        });

        if (matchedPairs == _game.cardCount ~/ 2) {
          _timer.cancel();
          _saveHighScore(); // บันทึก high score เมื่อจบด่าน
          showLevelCompleteDialog();
        }
      } else {
        // จับคู่ผิด ไม่ให้คะแนน และอาจลดคะแนนถ้าต้องการ
        setState(() {
          score = score > 1.5
              ? score - 1.5
              : 0; // ลดคะแนน 1.5 คะแนนเมื่อจับคู่ผิด แต่ไม่ติดลบ
          mismatchedCardIndices = [
            firstIndex,
            secondIndex
          ]; // Track mismatched cards
        });
        playLevelCompleteSound(); // Play sound when level is completed
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            _game.gameImg![firstIndex] = _game.hiddenCardpath;
            _game.gameImg![secondIndex] = _game.hiddenCardpath;
            mismatchedCardIndices.clear(); // Clear mismatched cards after delay
          });
          playCardMismatchSound(); // Play sound again when cards are flipped back
        });
      }

      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _game.matchCheck.clear();
          revealedCards.clear();
        });
      });
    }
  }

  void startGame() {
    setState(() {
      _gameStarted = true;
      _game.gameImg =
          List.filled(_game.cardCount, _game.hiddenCardpath); // Hide cards
      startTimer();
    });
  }

  // Method to play sound
  void playCardSound() async {
    await _audioPlayer.play(AssetSource(
        'sounds/card_flip.mp3')); // Adjust the path to your sound file
  }

  // Method to play level complete sound
  void playLevelCompleteSound() async {
    await _audioPlayer.play(AssetSource(
        'sounds/level_complete.mp3')); // Adjust the path to your sound file
  }

  // Method to play card mismatch sound
  void playCardMismatchSound() async {
    await _audioPlayer.play(AssetSource(
        'sounds/card_mismatch.mp3')); // Adjust the path to your sound file
  }

  // Method to play time running out sound
  void playTimeRunningOutSound() async {
    await _audioPlayer.play(AssetSource(
        'sounds/time_running_out.mp3')); // Adjust the path to your sound file
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Exit the game'),
                            content: Text('Do you want to quit the game?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // ปิด AlertDialog
                                  // ออกจากเกมส์โดยไม่ทำอะไร
                                },
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // ปิด AlertDialog
                                  Navigator.pop(context); // กลับไปหน้าหลัก
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Text('Level 2',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  info_card("Tries", "$tries"),
                  info_card("Score",
                      "${score.toStringAsFixed(1)}"), // แสดง score เป็นทศนิยม 1 ตำแหน่ง
                  info_card("High Score",
                      "$level2HighScore"), // แสดง high score ของ Level 2
                  info_card("Time",
                      "${_timeLeft ~/ 60}:${(_timeLeft % 60).toString().padLeft(2, '0')}"),
                  // Wrap the button in an AnimatedCrossFade to control its visibility
                  AnimatedCrossFade(
                    firstChild: PixelGameButton(
                      height: 50,
                      width: 120,
                      text: 'Start Game',
                      onTap: _gameStarted ? () {} : startGame,
                      onTapUp: () {},
                      onTapDown: () {},
                      onTapCancel: () {},
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                    ),
                    secondChild: SizedBox
                        .shrink(), // Empty space when the button is hidden
                    crossFadeState: _gameStarted
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 300), // Animation duration
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.7, // ปรับความสูงให้เหมาะสมกับหน้าจอแนวนอน
              child: GridView.builder(
                itemCount: _game.gameImg!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, // ปรับจำนวนคอลัมน์ให้เป็น 4 คอลัมน์
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0), // เพิ่ม padding รอบๆ GridView
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (_gameStarted && // Check if the game has started
                          !revealedCards.contains(index) &&
                          revealedCards.length < 2 &&
                          !matchedCardIndices.contains(index)) {
                        setState(() {
                          tries++;
                          _game.gameImg![index] = _game.cards_list[index];
                          revealedCards.add(index);
                          _game.matchCheck
                              .add({index: _game.cards_list[index]});
                        });

                        playCardSound(); // Play sound when a card is tapped

                        if (revealedCards.length == 2) {
                          checkMatch();
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width *
                              0.04), // 4% of screen width
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surface, // Use theme color
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(_game.gameImg![index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
