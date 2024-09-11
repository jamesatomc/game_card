import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart'; // Import FlameAudio

class BackButtonOverlay extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback onResumeMusic; // Add onResumeMusic parameter

  BackButtonOverlay({super.key, required this.onPressed, required this.onResumeMusic}); // Add onResumeMusic parameter

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource(
        'sounds/button_click.mp3')); // Adjust the path to your sound file
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      child: ElevatedButton(
        onPressed: () {
          _playSound();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Exit Game'),
                content: const Text('Are you sure you want to exit?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      _playSound(); // Play sound when "No" is pressed
                      Navigator.of(context).pop(); // ปิด dialog
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      _playSound(); // Play sound when "Yes" is pressed
                      FlameAudio.bgm.stop(); // Stop the background music
                      Navigator.pop(context); // Close the dialog
                      Navigator.pop(context); // Go back to the previous screen
                      onResumeMusic(); // Resume background music
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