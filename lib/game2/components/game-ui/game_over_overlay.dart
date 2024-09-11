import 'package:flutter/material.dart';

class GameOverOverlay extends StatelessWidget {
  final VoidCallback onRestart;

  const GameOverOverlay({Key? key, required this.onRestart}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bg2.png'), // ใช้พื้นหลังแบบพิกเซล
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 600, // กำหนดความกว้าง
            height: 400, // กำหนดความยาว
            padding: const EdgeInsets.all(16), // เพิ่ม padding ภายใน Container
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6), // สีพื้นหลังที่โปร่งแสง
              border: Border.all(
                color: Colors.white, // สีของกรอบ
                width: 2, // ความหนาของกรอบ
              ),
              borderRadius: BorderRadius.circular(20), // มุมโค้งของกรอบ
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'แย่จัง! ไม่เป็นไรนะ',
                    style: TextStyle(
                      fontFamily: 'Itim-Regular',
                      fontSize: 48,
                      color: Colors.black,
                      shadows: [
                        Shadow(
                          blurRadius: 0,
                          color: Colors.white,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRestart,
              child: Text('ลองอีกครั้ง'),
            ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // return Container(
    //   color: const Color.fromARGB(255, 186, 186, 186), // Set the background color to white
    //   child: Center(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         const Text(
    //           'Game Over',
    //           style: TextStyle(fontSize: 48, color: Colors.red),
    //         ),
    //         SizedBox(height: 20),
    //         ElevatedButton(
    //           onPressed: onRestart,
    //           child: Text('Restart'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}