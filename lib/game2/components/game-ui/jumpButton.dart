import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart'hide Route;

class JumpButton extends PositionComponent with TapCallbacks {
  final VoidCallback onJumpButtonPressed;

  JumpButton({required this.onJumpButtonPressed}) {
    size = Vector2(100, 100);
    position = Vector2(600, 500);
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    // print('Jump button tapped');
    onJumpButtonPressed();  // เรียก callback function
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = const Color.fromARGB(65, 103, 104, 105).withOpacity(0.75);
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Jump',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.x);

    textPainter.paint(
      canvas,
      Offset((size.x - textPainter.width) / 2, (size.y - textPainter.height) / 2),
    );
  }
}
