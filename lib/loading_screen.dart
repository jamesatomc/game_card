import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cardgame/name_input_screen.dart';
import 'package:flutter_cardgame/manu_game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _progress = 0.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  Future<void> _startLoading() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');

    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _progress += 0.01;
        if (_progress >= 1.0) {
          _timer.cancel();
          if (username == null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NameInputScreen(onSave: _saveUsername),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ManuGame(username: username),
              ),
            );
          }
        }
      });
    });
  }

  Future<void> _saveUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/gamecard/bg_pixel1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/gamecard/two.gif",
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width * 0.7) * _progress,
                      color: Colors.green,
                    ),
                    Center(
                      child: Text(
                        'LOADING ${(_progress * 100).toInt()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'PixelFont',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}