import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'player.dart';

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


class BackButtonOverlay extends StatelessWidget {
  final VoidCallback onPressed;

  const BackButtonOverlay({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('ออกจากเกมส์'),
                content: const Text('คุณต้องการออกจากเกมส์หรือไม่?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // ปิด dialog
                    },
                    child: const Text('ไม่'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // ปิด dialog
                      onPressed(); // เรียกใช้ onPressed เพื่อกลับไปหน้าก่อนหน้า
                    },
                    child: const Text('ใช่'),
                  ),
                ],
              );
            },
          );
        },
        child: const Text('กลับ'),
      ),
    );
  }
}