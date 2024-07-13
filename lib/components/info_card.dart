import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

Widget info_card(String title, String info) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shadowColor: Colors.brown,
        color: Colors.white,
        elevation: 10.0, // ปรับ margin ให้เล็กลง
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // จัดตำแหน่งข้อความให้ตรงกลาง
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.brown,
                fontSize: 16.0, // ปรับขนาดฟอนต์ให้เล็กลง
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 3.0, // ปรับระยะห่างระหว่างข้อความให้เล็กลง
            ),
            Text(
            
              info,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.brown), // ปรับขนาดฟอนต์ให้เล็กลง
            ),
          ],
        ),
      ),
    ),
  );
}

