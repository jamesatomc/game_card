// ignore: file_names
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioManager {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static bool _isPlaying = false;

  static Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isPlaying = prefs.getBool('musicEnabled') ?? true; // Default to true
    if (_isPlaying) {
      playMusic();
    }
  }

  static Future<void> stopMusic() async {
    if (_audioPlayer.state == PlayerState.playing) { 
      await _audioPlayer.stop(); 
      _isPlaying = false; // Update _isPlaying when stopping
    }
  }

  static Future<void> playMusic() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop); // Set loop mode
    await _audioPlayer.play(
      AssetSource('audio/lofi.mp3'),
      volume: 0.6, // Set volume to 30%
    );
    _isPlaying = true;
  }

  static Future<void> pauseMusic() async {
    await _audioPlayer.pause();
    _isPlaying = false;
  }

  static Future<void> toggleMusic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_isPlaying) {
      await pauseMusic();
    } else {
      await playMusic();
    }
    prefs.setBool('musicEnabled', _isPlaying);
  }

  static bool get isPlaying => _isPlaying; 
}
