import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart' hide Route;

class JumpButton extends PositionComponent with TapCallbacks {
  final Function(bool) onJumpButtonPressed;
  bool _enabled = true;
  final Duration cooldown = Duration(seconds: 1); // Cooldown period
  DateTime? lastJumpTime;

  JumpButton({required this.onJumpButtonPressed}) {
    size = Vector2(100, 100);
    position = Vector2(600, 500);
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if (_enabled && _canJump()) {
      onJumpButtonPressed(true);
      lastJumpTime = DateTime.now();
    }
  }

  bool _canJump() {
    if (lastJumpTime == null) {
      return true;
    }
    return DateTime.now().difference(lastJumpTime!) >= cooldown;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = _enabled
          ? const Color.fromARGB(65, 103, 104, 105).withOpacity(0.75)
          : Colors.grey.withOpacity(0.5);
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);

    final textPainter = TextPaint(
      style: TextStyle(color: _enabled ? Colors.white : Colors.grey, fontSize: 20),
    );
    textPainter.render(
      canvas,
      'Jump',
      Vector2(size.x / 2, size.y / 2),
      anchor: Anchor.center,
    );
  }

  void setEnabled(bool enabled) {
    _enabled = enabled;
  }
}