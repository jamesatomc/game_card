import 'package:flutter/material.dart';

class GameButton extends StatefulWidget {
  final double height;
  final double shadowHeight;
  final double position;
  final String text;
  final Function onTap;
  final Function onTapUp;
  final Function onTapDown;
  final Function onTapCancel;

  const GameButton({
    Key? key,
    required this.height,
    required this.shadowHeight,
    required this.position,
    required this.text,
    required this.onTap,
    required this.onTapUp,
    required this.onTapDown,
    required this.onTapCancel,
  }) : super(key: key);

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 260, // Makes the button take the full width of its parent
      child: GestureDetector(
        onTap: () => widget.onTap(),
        onTapUp: (_) => widget.onTapUp(),
        onTapDown: (_) => widget.onTapDown(),
        onTapCancel: () => widget.onTapCancel(),
        child: Container(
          height: widget.height + widget.shadowHeight,
          width: 200,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: widget.height,
                  width: 200,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: Curves.easeIn,
                bottom: widget.position,
                duration: Duration(milliseconds: 70),
                child: Container(
                  height: widget.height,
                  width: 200,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}