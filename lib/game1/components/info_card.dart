import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

Widget info_card(String title, String info) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Card(
        shadowColor: Colors.black,
        color: Colors.white,
        elevation: 10.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'PixelFont', // Use a pixel font
                color: Colors.black,
                fontSize: 18.0, // Adjust font size for pixel art style
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.0, // Adjust spacing for pixel art style
            ),
            Text(
              info,
              style: TextStyle(
                fontFamily: 'PixelFont', // Use a pixel font
                fontSize: 16.0, 
                fontWeight: FontWeight.bold, 
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

