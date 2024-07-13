import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cardgame/components/info_card.dart';
import 'package:flutter_cardgame/utils/game_utils.dart';

import 'LevelTwoScreen.dart';

class LevelOneScreen extends StatefulWidget {
  const LevelOneScreen({super.key});

  @override
  _LevelOneScreenState createState() => _LevelOneScreenState();
}

class _LevelOneScreenState extends State<LevelOneScreen> {
  //setting text style
  bool hideTest = false;
  final Game _game = Game();

  //game stats
  int tries = 0;
  int score = 0;

  int matchedPairs = 0;
  late Timer _timer;
  int _timeLeft = 110; // 1:50 นาที = 110 วินาที

  List<int> revealedCards = [];
  List<int> matchedCardIndices = []; // เพิ่ม list สำหรับเก็บ index ของไพ่ที่จับคู่กันแล้ว

  @override
  void initState() {
    super.initState();
    _game.initGame();
    revealedCards.clear();
    matchedCardIndices.clear(); // เริ่มต้น list ของไพ่ที่จับคู่กันแล้ว
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
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
          });
        }
      },
    );
  }

  void showLevelCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Level Complete!'),
          content: Text('Congratulations! You\'ve completed Level 1.'),
          actions: <Widget>[
            TextButton(
              child: Text('Next Level'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LevelTwoScreen()),
                );
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
      _timeLeft = 110;
      revealedCards.clear();
      matchedCardIndices.clear(); // เริ่มต้น list ของไพ่ที่จับคู่กันแล้ว
    });
    startTimer();
  }

  void checkMatch() {
    if (_game.matchCheck.length == 2) {
      int firstIndex = _game.matchCheck[0].keys.first;
      int secondIndex = _game.matchCheck[1].keys.first;

      if (_game.checkMatch(firstIndex, secondIndex)) {
        setState(() {
          score += 10;
          matchedPairs++;
          matchedCardIndices.addAll([firstIndex, secondIndex]); // เพิ่ม index ของไพ่ที่จับคู่กันแล้ว
        });

        if (matchedPairs == _game.cardCount ~/ 2) {
          _timer.cancel();
          showLevelCompleteDialog();
        }
      } else {
        // จับคู่ผิด ไม่ให้คะแนน และอาจลดคะแนนถ้าต้องการ
        setState(() {
          score = score > 0 ? score - 5 : 0; // ลดคะแนน 1 คะแนนเมื่อจับคู่ผิด แต่ไม่ติดลบ
        });
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            _game.gameImg![firstIndex] = _game.hiddenCardpath;
            _game.gameImg![secondIndex] = _game.hiddenCardpath;
          });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Level 1"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // This line pops the current screen off the navigation stack
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "คำใบ้",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 1.0,
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                info_card("Tries", "$tries"),
                info_card("Score", "$score"),
                info_card(
                    "Time", "${_timeLeft ~/ 60}:${(_timeLeft % 60).toString().padLeft(2, '0')}"),
              ],
            ),
             Padding(
               padding: const EdgeInsets.all(50.0),
               child: SizedBox(
                 height: MediaQuery.of(context).size.width,
                 width: MediaQuery.of(context).size.width,
                 child: GridView.builder(
                   itemCount: _game.gameImg!.length,
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 8,
                     crossAxisSpacing: 16.0,
                     mainAxisSpacing: 16.0,
                   ),
                   padding: EdgeInsets.all(16.0),
                   itemBuilder: (context, index) {
                     return GestureDetector(
                       onTap: () {
                         if (!revealedCards.contains(index) &&
                             revealedCards.length < 2 &&
                             !matchedCardIndices.contains(index)) {
                           setState(() {
                             tries++;
                             _game.gameImg![index] = _game.cards_list[index];
                             revealedCards.add(index);
                             _game.matchCheck.add({index: _game.cards_list[index]});
                           });
                       
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
                               offset: const Offset(0, 3), // changes position of shadow
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
             ),
          ],
        ),
      ),
    );
  }
}
