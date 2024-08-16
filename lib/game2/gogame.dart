import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'components/player.dart';

class MyGame extends FlameGame with HasKeyboardHandlerComponents {
  final player = Player2();
  final player2 = Player2();

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    player.position = Vector2(150, 50);
    add(player);
    overlays.add('BackButton');
  }

  @override
  Color backgroundColor() => Color.fromARGB(255, 230, 18, 18);
}
