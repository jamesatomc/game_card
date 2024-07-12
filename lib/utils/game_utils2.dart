import 'dart:math';

import 'package:flutter/material.dart';

class Game {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;
  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue,
    Colors.grey,
    Colors.grey,
  ];
  final String hiddenCardpath = "assets/images/hidden.png";
  // ignore: non_constant_identifier_names
  List<String> cards_list = [
    "assets/images/circle.png",
    "assets/images/triangle.png",
    "assets/images/circle.png",
    "assets/images/heart.png",
    "assets/images/star.png",
    "assets/images/triangle.png",
    "assets/images/star.png",
     "assets/images/star.png",
    "assets/images/star.png",
    "assets/images/heart.png",
  ];
  final int cardCount = 10;
  List<Map<int, String>> matchCheck = [];

  //methods
  void initGame() {
    
    // Shuffle the cards and cards_list
    cards.shuffle(Random());
    cards_list.shuffle(Random());

    // Generate gameColors and gameImg based on shuffled lists
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
