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

  const BackButtonOverlay({super.key, required this.onPressed});

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
                title: const Text('Exit Game'),
                content: const Text('Are you sure you want to exit?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // ปิด dialog
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // ปิด dialog
                      onPressed(); // เรียกใช้ onPressed เพื่อกลับไปหน้าก่อนหน้า
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(), // ทำให้ปุ่มเป็นวงกลม
          padding: const EdgeInsets.all(16.0), // เพิ่ม padding รอบๆ ปุ่ม
          backgroundColor: Colors.transparent, // ทำให้พื้นหลังปุ่มโปร่งใส
        ),
        child: const Icon(
          Icons.arrow_back, // เปลี่ยนข้อความเป็น Icon ลูกศรย้อนกลับ
          color: Colors.white, // ตั้งค่าสีของ Icon
          size: 32.0, // ตั้งค่าขนาดของ Icon
        ),
      ),
    );
  }
}
