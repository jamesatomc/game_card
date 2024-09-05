import 'package:flutter/material.dart';

class Howtoplay2 extends StatefulWidget {
  const Howtoplay2({super.key});

  @override
  State<Howtoplay2> createState() => _Howtoplay2State();
}

class _Howtoplay2State extends State<Howtoplay2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('How to Play'),
      ),
      body: Center(
        child: Text('How to play'),
      ),
    );
  }
}