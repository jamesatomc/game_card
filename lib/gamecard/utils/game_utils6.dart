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
    Colors.blue
  ];
  final String hiddenCardpath = "assets/gamecard/hidden.png";
  // ignore: non_constant_identifier_names
  List<String> cards_list = [
    "assets/gamecard/england/l6/data_1.png",
    "assets/gamecard/england/l6/data_2.png",
    "assets/gamecard/england/l6/data_3.png",
    "assets/gamecard/england/l6/data_4.png",
    "assets/gamecard/england/l6/data_5.png",
    "assets/gamecard/images/im6/data_1.png",
    "assets/gamecard/images/im6/data_2.png",
    "assets/gamecard/images/im6/data_3.png",
    "assets/gamecard/images/im6/data_4.png",
    "assets/gamecard/images/im6/data_5.png",
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

  // Function to check if two cards match
  bool checkMatch(int cardIndex1, int cardIndex2) {
    // Extract the image paths from the shuffled list
    String imgPath1 = cards_list[cardIndex1];
    String imgPath2 = cards_list[cardIndex2];

    // Check if the image paths are a match (ignoring the folder structure)
    return imgPath1.split('/').last == imgPath2.split('/').last;
  }
}
