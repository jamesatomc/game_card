import 'package:flutter/material.dart';

class WinOverlay extends StatelessWidget {
  final VoidCallback onNextQuiz;

  const WinOverlay({required this.onNextQuiz, Key? key}) : super(key: key);

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
                    'เย้!ยินดีด้วยคุนผ่านด่านแล้ว',
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
                  ElevatedButton(
                    onPressed: onNextQuiz,
                    child: Text('Go to Quiz'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // return Container(
    //   color: Colors.blueAccent, // Set the background color
    //   child: Center(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [

    //         // Text(
    //         //   'Congratulations!',
    //         //   style: TextStyle(fontSize: 30, color: Colors.green),
    //         // ),
    //         SizedBox(height: 20),
    //         ElevatedButton(
    //           onPressed: onNextQuiz,
    //           child: Text('Go to Quiz'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
