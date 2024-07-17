import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';

class Player2 extends SpriteAnimationComponent
    with HasGameRef, KeyboardHandler {
  Player2()
      : super(
          size: Vector2(100, 100),anchor: Anchor.center,
        );

  late SpriteAnimation stand;

  double moveSpeed = 300;
  int horizontal = 0;
  final velocity = Vector2.zero();

  @override
  Future<void> onLoad() async {
    await loadAnimation().then((_) => animation = stand);
    return super.onLoad();
  }

  Future<void> loadAnimation() async {
    final spriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images.load('Bite.png'), columns: 11, rows: 1);

    stand = spriteSheet.createAnimation(
        row: 0,
        stepTime: 0.15,
        from: 0,
        to: 11); // Assuming the animation starts at row 0
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontal = 0;
    

    horizontal += (keysPressed.contains(LogicalKeyboardKey.keyA) ? -1 : 0);
    horizontal += (keysPressed.contains(LogicalKeyboardKey.keyD) ? 1 : 0);

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocity.x = horizontal * moveSpeed;
    position += velocity * dt;

    if ((horizontal > 0 && scale.x < 0) || (horizontal < 0 && scale.x > 0)) {}
    }
  
}
