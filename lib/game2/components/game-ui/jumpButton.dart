import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart' hide Route;
import 'dart:async' as dart_async;

class JumpButton extends PositionComponent with TapCallbacks {
  final Function(bool) onJumpButtonPressed;
  bool _enabled = true;
  int _pressCount = 0;
  dart_async.Timer? _cooldownTimer;

  JumpButton({required this.onJumpButtonPressed}) {
    size = Vector2(100, 100);
    position = Vector2(600, 500);
  }

  @override
  void onTapUp(TapUpEvent event) {
    // คือการกำหนดการทำงานเมื่อมีการกดปุ่ม
    super.onTapUp(event);
    if (_enabled && _pressCount < 2) {
      onJumpButtonPressed(true);
      _pressCount++;
      if (_pressCount == 2) {
        _startCooldown();
      }
    }
  }
  // ฟังก์ชันที่ใช้ในการกำหนดเวลาในการกดปุ่ม
  void _startCooldown() {
    _enabled = false;
    _cooldownTimer = dart_async.Timer(const Duration(seconds: 1), () {
      _enabled = true;
      _pressCount = 0;
    });
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