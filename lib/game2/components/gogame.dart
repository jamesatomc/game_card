import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'player.dart';

// class Gogame extends FlameGame {
//   Gogame({super.children});

//   @override
//   FutureOr<void> onLoad() async {
//     super.onLoad();

//     world.add(Player(
//       position: Vector2(0, 0),
//       radius: 50
//     ));
//   }

//   @override
//   Color backgroundColor() => Color.fromARGB(255, 189, 235, 82);
// }

class MyGame extends FlameGame with HasKeyboardHandlerComponents {
  final player = Player2();
  final player2 = Player2();

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    player.position = Vector2(150, 50);
    add(player);
  }

}
