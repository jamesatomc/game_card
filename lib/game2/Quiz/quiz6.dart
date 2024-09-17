import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../../components/game_button.dart';
import '../Level/Jump1.dart';
import '../components/BackButtonOverlay.dart';

class Quiz6 extends StatefulWidget {
  final VoidCallback? onResumeMusic; // Add this property

  const Quiz6({Key? key, this.onResumeMusic}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Quiz1State createState() => _Quiz1State();
}

class _Quiz1State extends State<Quiz6> {
  List<Question> questions = [
    // Add your questions here, following the same format as below:
    Question(
      'She __________ her bike in the park now.',
      ['is riding', 'rides', 'riding', 'ride'],
      0,
    ),
    Question(
      'They __________ to their teacher about the project.',
      ['talks', 'are talking', 'talk', 'talked'],
      1,
    ),
    Question(
      'I __________ a letter to my friend at the moment.',
      ['writing', 'am writing', 'writes', 'write'],
      1,
    ),
    Question(
      'You __________ very well today.',
      ['are singing', 'a sings', 'sing', 'sung'],
      0,
    ),
    Question(
      'The cat __________ on the sofa right now',
      ['is sleeping', 'sleeps', 'sleeping', 'sleep'],
      0,
    ),
    Question(
      'We __________ dinner at the moment.',
      ['having', 'are having', 'have', 'had'],
      1,
    ),
    Question(
      'He __________ a new movie now.',
      ['watch', 'watches', 'is watching', 'watched'],
      2,
    ),
    Question(
      'They __________ to music at the moment.',
      ['listens', 'listen', 'are listen', 'listend'],
      2,
    ),
    Question(
      'I __________ my homework this afternoon.',
      ['am doing', 'do', 'doing', 'does'],
      0,
    ),
     Question(
      'She __________ a book right now.',
      ['reads', 'read', 'is reading ', 'readed'],
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
      if (selectedIndex != currentQuestion.correctAnswerIndex) {
        incorrectAnswers++;
      }
      answeredQuestions++;
    });

    // Delay to show the answer before loading the next question
    Future.delayed(const Duration(seconds: 1), () {
      if (answeredQuestions >= totalQuestions) {
        _showCompletionScreen();
      } else if (incorrectAnswers >= maxIncorrectAnswers) {
        // _resetQuiz();  //  <-- Remove this line
        _showFailScreen(); // <-- Add this line
      } else {
        _loadRandomQuestion();
      }
    });
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
                    Navigator.pop(context);
                  }, onResumeMusic: () { widget.onResumeMusic?.call(); },
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
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Go back to the previous screen
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        leading: IconButton(
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
                        Navigator.of(context).pop(); // ปิด AlertDialog
                        // ออกจากเกมส์โดยไม่ทำอะไร
                      },
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // ปิด AlertDialog
                        Navigator.pop(context); // กลับไปหน้าหลัก
                        widget.onResumeMusic
                            ?.call(); // Call the function to resume music
                      },
                      child: Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/background.png"), // Replace with your image path
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                                                Container(
                          padding: const EdgeInsets.all(50.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(
                                0.8), // Semi-transparent white background
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            currentQuestion.text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Itim-Regular',
                                fontSize: 30, color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10,width: 10,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
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
                              const SizedBox(height: 10), // Space between rows
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
                        const SizedBox(height: 12),
                        if (showAnswer) ...[
                          const SizedBox(height: 6),
                          Text(
                            'คำตอบที่ถูกต้อง: ${currentQuestion.answers[currentQuestion.correctAnswerIndex]}',
                            style: const TextStyle(fontFamily: 'Itim-Regular',
                                color: Colors.green, fontSize: 16),
                          ),
                        ],
                        if (incorrectAnswers >= maxIncorrectAnswers) ...[
                          const SizedBox(height: 20),
                          const Text(
                            'ตอบผิดเกิน 2 ครั้ง',
                            style: TextStyle(fontFamily: 'Itim-Regular',color: Colors.red, fontSize: 16),
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
        buttonColor = Colors.blueGrey;
      }
    } else {
      buttonColor = Colors.blueGrey;
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
