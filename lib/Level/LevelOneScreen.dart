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

  @override
  void initState() {
    super.initState();
    _game.initGame();
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
  });
  startTimer();
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
                "Level 1",
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                info_card("Tries", "$tries"),
                info_card("Score", "$score"),
                info_card("Time", "${_timeLeft ~/ 60}:${(_timeLeft % 60).toString().padLeft(2, '0')}"),

              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                itemCount: _game.gameImg!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                padding: EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print(_game.matchCheck);
                      setState(() {
                        //incrementing the clicks
                        tries++;
                        _game.gameImg![index] = _game.cards_list[index];
                        _game.matchCheck.add({index: _game.cards_list[index]});
                        print(_game.matchCheck.first);
                      });
                      if (_game.matchCheck.length == 2) {
                        if (_game.matchCheck[0].values.first == _game.matchCheck[1].values.first) {
                          print("true");
                          score += 100;
                          matchedPairs++;
                          _game.matchCheck.clear();
                          if (matchedPairs == _game.cardCount ~/ 2) {
                            _timer.cancel();
                            showLevelCompleteDialog();
                          }
                        } else {
                          print("false");

                          Future.delayed(Duration(milliseconds: 500), () {
                            print(_game.gameColors);
                            setState(() {
                              _game.gameImg![_game.matchCheck[0].keys.first] = _game.hiddenCardpath;
                              _game.gameImg![_game.matchCheck[1].keys.first] = _game.hiddenCardpath;
                              _game.matchCheck.clear();
                            });
                          });
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
                            offset: Offset(0, 3), // changes position of shadow
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
