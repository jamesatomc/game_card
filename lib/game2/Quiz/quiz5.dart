import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

import '../../components/game_button.dart';
import '../GameJump.dart';
import '../Level/Jump1.dart';
import '../components/BackButtonOverlay.dart';

class Quiz5 extends StatefulWidget {
  final VoidCallback? onResumeMusic; // Add this property

  const Quiz5({Key? key, this.onResumeMusic}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Quiz5State createState() => _Quiz5State();
}

class _Quiz5State extends State<Quiz5> {
  List<Question> questions = [
    // Add your questions here, following the same format as below:
    Question(
      'What is the capital of France?',
      ['Berlin', 'Paris', 'Madrid', 'Rome'],
      1,
    ),
    Question(
      'What is the capital of Germany?',
      ['Berlin', 'Paris', 'Madrid', 'Rome'],
      0,
    ),
    Question(
      'What is the capital of Spain?',
      ['Berlin', 'Paris', 'Madrid', 'Rome'],
      2,
    ),
    // More questions...
  ];

  late List<Question> remainingQuestions;
  late Question currentQuestion;
  int? selectedAnswerIndex;
  bool showAnswer = false;
  int incorrectAnswers = 0;
  int answeredQuestions = 0;
  final int maxIncorrectAnswers = 2;
  final int totalQuestions = 3;
  final Random random = Random();
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    remainingQuestions = List.from(questions);
    _loadRandomQuestion();
  }

  void _loadRandomQuestion() {
    setState(() {
      if (remainingQuestions.isEmpty) {
        remainingQuestions = List.from(questions);
      }
      currentQuestion = remainingQuestions
          .removeAt(random.nextInt(remainingQuestions.length));
      selectedAnswerIndex = null;
      showAnswer = false;
    });
  }

  void _checkAnswer(int selectedIndex) {
    if (selectedAnswerIndex != null) return; // Prevent multiple presses

    setState(() {
      selectedAnswerIndex = selectedIndex;
      showAnswer = true;
      if (selectedIndex == currentQuestion.correctAnswerIndex) {
        _playCorrectAnswerSound();
        answeredQuestions++;
      } else {
        _playIncorrectAnswerSound();
        incorrectAnswers++;
      }
    });

    // Delay to show the answer before loading the next question
    Future.delayed(const Duration(seconds: 3), () {
      if (answeredQuestions >= totalQuestions) {
        _showCompletionScreen();
      } else if (answeredQuestions >= 2 && incorrectAnswers >= 3) {
        // Check if 2 correct answers
        _showCompletionScreen();
      } else if (incorrectAnswers >= maxIncorrectAnswers) {
        _showFailScreen();
      } else {
        _loadRandomQuestion();
      }
    });
  }

  void _playCorrectAnswerSound() async {
    await audioPlayer.play(AssetSource('sounds/correct.mp3'));
  }

  void _playIncorrectAnswerSound() async {
    await audioPlayer.play(AssetSource('sounds/wrong-buzzer.mp3'));
  }

  void _resetQuiz() {
    setState(() {
      incorrectAnswers = 0;
      answeredQuestions = 0;
      remainingQuestions = List.from(questions);
      _loadRandomQuestion();
    });
  }

  void _showCompletionScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameWidget(
          game: Jump1(),
          overlayBuilderMap: {
            'BackButton': (context, game) => BackButtonOverlay(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => GameJump()),
                    );
                  },
                  onResumeMusic: () {},
                ),
          },
        ),
      ),
    );
  }

  void _showFailScreen() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('เสียใจด้วย'),
          content: const Text('คุณต้องการลองอีกครั้งหรือไม่?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GameJump()),
                );
                widget.onResumeMusic
                    ?.call(); // Call the function to resume music
              },
              child: const Text('ออกจากเกม'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetQuiz();
              },
              child: const Text('ลองอีกครั้ง'),
            ),
          ],
        );
      },
    );
  }

  void showExitDialog(BuildContext context, Function? onResumeMusic) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exit the game'),
          content: Text('Do you want to quit the game?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด AlertDialog
                // ออกจากเกมส์โดยไม่ทำอะไร
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
                onResumeMusic?.call(); // Call the function to resume music
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/gamecard/bg.png"), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back),
                                color: Colors.white,
                                iconSize: 30,
                                onPressed: () {
                                  showExitDialog(context, widget.onResumeMusic);
                                },
                              ),
                              Expanded(
                                child: Text(
                                  'Quiz',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 700,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            currentQuestion.text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              fontFamily: 'Itim-Regular',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildAnswerButton(0),
                                  const SizedBox(
                                      width: 10), // Space between buttons
                                  _buildAnswerButton(1),
                                ],
                              ),
                              const SizedBox(height: 8), // Space between rows
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildAnswerButton(2),
                                  const SizedBox(
                                      width: 10), // Space between buttons
                                  _buildAnswerButton(3),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        if (showAnswer) ...[
                          const SizedBox(height: 6),
                          Text(
                            'คำตอบที่ถูกต้อง: ${currentQuestion.answers[currentQuestion.correctAnswerIndex]}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ],
                        if (incorrectAnswers >= maxIncorrectAnswers) ...[
                          const SizedBox(height: 6),
                          const Text(
                            'ตอบผิดเกิน 2 ครั้ง',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnswerButton(int index) {
    Color buttonColor;
    if (showAnswer) {
      if (index == currentQuestion.correctAnswerIndex) {
        buttonColor = Colors.green;
      } else if (index == selectedAnswerIndex) {
        buttonColor = Colors.red;
      } else {
        buttonColor = const Color.fromARGB(255, 216, 125, 7);
      }
    } else {
      buttonColor = const Color.fromARGB(255, 216, 125, 7);
    }

    return Expanded(
      child: PixelGameButton(
        height: 50,
        width: 100,
        text: currentQuestion.answers[index],
        onTap: () {
          _checkAnswer(index);
        },
        onTapUp: () {},
        onTapDown: () {},
        onTapCancel: () {},
        backgroundColor: buttonColor,
        textColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class Question {
  final String text;
  final List<String> answers;
  final int correctAnswerIndex;

  Question(this.text, this.answers, this.correctAnswerIndex);
}