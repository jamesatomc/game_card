import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

Widget info_card(String title, String info) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.all(10.0), // ปรับ margin ให้เล็กลง
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // ปรับ padding ให้เล็กลง
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // เพิ่มมุมมนให้กับ card
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // จัดตำแหน่งข้อความให้ตรงกลาง
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0, // ปรับขนาดฟอนต์ให้เล็กลง
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 3.0, // ปรับระยะห่างระหว่างข้อความให้เล็กลง
          ),
          Text(
            info,
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold), // ปรับขนาดฟอนต์ให้เล็กลง
          ),
        ],
      ),
    ),
  );
}

