import 'package:flutter/material.dart';

class PixelGameButton extends StatefulWidget {
  final double height;
  final double width;
  final String text;
  final VoidCallback onTap;
  final VoidCallback onTapUp;
  final VoidCallback onTapDown;
  final VoidCallback onTapCancel;
  final Color backgroundColor;
  final Color textColor;

  const PixelGameButton({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
    required this.onTap,
    required this.onTapUp,
    required this.onTapDown,
    required this.onTapCancel,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  _PixelGameButtonState createState() => _PixelGameButtonState();
}

class _PixelGameButtonState extends State<PixelGameButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        widget.onTapDown();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTapUp();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        widget.onTapCancel();
      },
      onTap: widget.onTap,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: [
            if (!_isPressed)
              BoxShadow(
                color: Colors.black,
                offset: Offset(4, 4),
              ),
          ],
        ),
        child: Stack(
          children: [
            // เอฟเฟกต์พิกเซลที่มุม
            if (!_isPressed) ...[
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
            // ข้อความปุ่ม
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: _isPressed ? 4 : 0, left: _isPressed ? 4 : 0),
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 20,
                    fontFamily: 'PixelFont',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}