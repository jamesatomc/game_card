import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import '../GmaeJump.dart';
import '../Level/Jump1.dart';
import '../components/BackButtonOverlay.dart';


class Quiz1 extends StatefulWidget {
  @override
  _Quiz1State createState() => _Quiz1State();
}

class _Quiz1State extends State<Quiz1> {
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
    Question(
      'What is the capital of Italy?',
      ['Berlin', 'Paris', 'Madrid', 'Rome'],
      3,
    ),
    Question(
      'What is the capital of Portugal?',
      ['Lisbon', 'Paris', 'Madrid', 'Rome'],
      0,
    ),
    // More questions...
  ];

  late List<Question> remainingQuestions;
  late Question currentQuestion;
  int? selectedAnswerIndex;
  bool showAnswer = false;
  int incorrectAnswers = 0;
  int answeredQuestions = 0;
  final int maxIncorrectAnswers = 3;
  final int totalQuestions = 5;
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
      currentQuestion = remainingQuestions.removeAt(random.nextInt(remainingQuestions.length));
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
        _resetQuiz();
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
                  },
                ),
          },
        ),
      ),
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => GmaeJump()), // Navigate back to MenuJump
            );
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"), // Replace with your image path
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
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8), // Semi-transparent white background
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            currentQuestion.text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildAnswerButton(0),
                                  const SizedBox(width: 20), // Space between buttons
                                  _buildAnswerButton(1),
                                ],
                              ),
                              const SizedBox(height: 20), // Space between rows
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildAnswerButton(2),
                                  const SizedBox(width: 20), // Space between buttons
                                  _buildAnswerButton(3),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        if (showAnswer) ...[
                          const SizedBox(height: 20),
                          Text(
                            'Correct Answer: ${currentQuestion.answers[currentQuestion.correctAnswerIndex]}',
                            style: const TextStyle(color: Colors.green, fontSize: 16),
                          ),
                        ],
                        if (incorrectAnswers >= maxIncorrectAnswers) ...[
                          const SizedBox(height: 20),
                          const Text(
                            'You have exceeded the maximum number of incorrect answers.',
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
        buttonColor = Colors.blueGrey;
      }
    } else {
      buttonColor = Colors.blueGrey;
    }

    return Expanded(
      child: ElevatedButton(
        onPressed: selectedAnswerIndex == null ? () => _checkAnswer(index) : null, // Disable button if an answer is selected
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: const EdgeInsets.all(16.0),
          textStyle: const TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(currentQuestion.answers[index]),
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