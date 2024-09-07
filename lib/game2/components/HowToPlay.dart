import 'package:flutter/material.dart';

class Howtoplay2 extends StatefulWidget {
  final VoidCallback? onResumeMusic; // Add this property

  const Howtoplay2({Key? key, this.onResumeMusic}) : super(key: key);

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
            Navigator.pop(context); // Close the dialog
            widget.onResumeMusic?.call(); // Call the function to resume music
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
