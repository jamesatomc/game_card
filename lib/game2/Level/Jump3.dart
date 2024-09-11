import 'package:flame/camera.dart';
import 'package:flutter/material.dart';
import 'package:game_somo/game2/Quiz/quiz3.dart';
import 'package:game_somo/game2/components/game-ui/medusa.dart';
import 'package:game_somo/game2/components/game-ui/suriken.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';

import '../Quiz/quiz2.dart';
import '../components/game-ui/bumpy.dart';
import '../components/game-ui/cion.dart';
import '../components/game-ui/game_over_overlay.dart';
import '../components/game-ui/ground.dart';
import '../components/game-ui/jumpButton.dart';
import '../components/game-ui/monsters.dart';
import '../components/game-ui/player.dart';
import '../components/game-ui/win_overlay.dart';

class Jump2 extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection, TapCallbacks {
  late Player myPlayer;
  late Cion myCoin;
  late Monsters monsters;

  late List<Vector2> grounds;
  late int mapWidth;
  late int mapHeight;
  late JoystickComponent joystick;
  late JoystickComponent jump;
  late SpriteComponent background;
  late Vector2 playerSpawnPoint; // Declare playerSpawnPoint here

  int lives = 2; // Start with 2 lives
  int initialLives = 2; // Store the initial number of lives
  int level2CoinScore = 0; // Track the number of coins collected
  int level2CoinScoreReset = 0; // New variable for resetting purposes

  late TextComponent livesText; // Declare a TextComponent for lives
  late TextComponent coinsText; // Declare a TextComponent for coins

  bool isPlayerDead = false; // Flag to track if the player is dead

  late JumpButton jumpButton;

  @override
  Future<void> onLoad() async {
    initialLives = lives; // Initialize initialLives in onLoad

    // Load the saved coin score
    level2CoinScore = await getLevel2CoinScore() ?? 0;

    // Initialize livesText
    livesText = TextComponent(
      text: 'Lives: $lives',
      position: Vector2(200, 30), // Position on the far left
      anchor: Anchor.topRight, // Align text to top-left
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 0, 0),
          fontSize: 20,
        ),
      ),
    );

    // Initialize coinsText
    coinsText = TextComponent(
      text: 'Coins: 0', // Initialize with 0 coins
      position: Vector2(livesText.position.x + livesText.size.x + 50,
          30), // Position to the right of livesText
      anchor: Anchor.topRight, // Align text to top-left
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 215, 0),
          fontSize: 20,
        ),
      ),
    );

    // Load the GIF background
    background = SpriteComponent()
      ..sprite = await loadSprite('bg2.gif')
      ..size = Vector2(1900, 700);
    FlameAudio.bgm.play("bg.mp3");

    // Add the background to the game world
    add(background);
    add(livesText);
    add(coinsText);
    overlays.add('BackButton');

    await loadLevel();

    joystick = JoystickComponent(
        knob: CircleComponent(
            radius: 30,
            paint: Paint()
              ..color =
                  const Color.fromARGB(255, 244, 240, 240).withOpacity(0.50)),
        background: CircleComponent(
            radius: 50, paint: Paint()..color = Colors.white.withOpacity(0.50)),
        margin: const EdgeInsets.only(left: 50, bottom: 30));
    await camera.viewport.add(joystick);

    joystick.priority = 0;

    jumpButton = JumpButton(onJumpButtonPressed: (bool jumped) {
      if (!isPlayerDead && jumped) {
        myPlayer.moveJump();
      }
    });
    world.add(jumpButton);
    await camera.viewport.add(jumpButton);

    // Register the game over overlay
    overlays.addEntry(
      'GameOver',
      (context, game) => GameOverOverlay(
        onRestart: restartGame,
      ),
    );

    // Register the win overlay
    overlays.addEntry(
      'Win',
      (context, game) => WinOverlay(
        onNextQuiz: () {
          FlameAudio.bgm.stop(); // Stop the background music

          // Navigate to Quiz2
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => quiz3(),
            ),
          );
        },
      ),
    );

    return super.onLoad();
  }

  Future<void> loadLevel() async {
    final level = await TiledComponent.load(
      "map2.tmx",
      Vector2.all(32),
    );

    FlameAudio.bgm.stop(); // Stop the background music

    mapWidth = (level.tileMap.map.width * level.tileMap.destTileSize.x).toInt();
    mapHeight =
        (level.tileMap.map.height * level.tileMap.destTileSize.y).toInt();
    world.add(level);

    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>("spawn");
    for (final spawnPoint in spawnPointsLayer!.objects) {
      switch (spawnPoint.class_) {
        case "player":
          playerSpawnPoint = spawnPoint.position; // Store the spawn point
          myPlayer = Player(position: spawnPoint.position);
          world.add(myPlayer);
          camera.follow(myPlayer); // Ensure camera follows the player
          break;
      }
    }

    final coinPointsLayer = level.tileMap.getLayer<ObjectGroup>("coin");
    for (final coinPoint in coinPointsLayer!.objects) {
      switch (coinPoint.class_) {
        case "coin":
          myCoin = Cion(position: coinPoint.position);
          world.add(myCoin);
          break;
      }
    }

    final monstersPointsLayer = level.tileMap.getLayer<ObjectGroup>("monsters");
    for (final monstersPoint in monstersPointsLayer!.objects) {
      switch (monstersPoint.class_) {
        case "monsters":
          monsters = Monsters(position: monstersPoint.position);
          world.add(monsters);
          break;

        case "bumpy":
          final bumpy = Bumpy(position: monstersPoint.position);
          world.add(bumpy);
          break;

        case "medusa":
          final medusa = Medusa(position: monstersPoint.position);
          world.add(medusa);
          break;

        case "suriken":
          final suriken = Suriken(position: monstersPoint.position);
          world.add(suriken);
          break;
      }
    }

    final groundLayer = level.tileMap.getLayer<ObjectGroup>("ground");
    for (final groundPoint in groundLayer!.objects) {
      final grounds =
          GroundBlock(position: groundPoint.position, size: groundPoint.size);
      world.add(grounds);
    }

    camera.viewport = FixedResolutionViewport(
      resolution: Vector2(720, 640),
    );

    camera.setBounds(
      Rectangle.fromLTRB(size.x / 2, size.y / 2.4, level.width - size.x / 2,
          level.height - size.y / 2),
    );

    // Set the camera anchor to the center
    camera.viewfinder.anchor = Anchor.center;
  }

    @override
  void onTapUp(TapUpEvent event) async {
    super.onTapUp(event);
    if (!isPlayerDead) {
      myPlayer.moveJump();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateJoystrick();

    // Check for collisions with monsters or bumpy
    if (myPlayer.hasCollided) {
      myPlayer.removeFromParent();
      respawnPlayer(); // Respawn the player immediately
    }

    // Check for collisions with coins
    for (final coin in world.children.whereType<Cion>()) {
      if (myPlayer.toRect().overlaps(coin.toRect())) {
        coin.removeFromParent();
        collectCoin(); // Call collectCoin when a coin is collected
      }
    }

    // Ensure the camera follows the player
    camera.follow(myPlayer);
  }

  void showGameOver() {
    overlays.add('GameOver');
  }

  void showWin() {
    overlays.add('Win');
  }

  void restartGame() {
    overlays.remove('GameOver');
    overlays.remove('Win');
    resetGame();
  }

  updateJoystrick() {
    if (!isPlayerDead) {
      switch (joystick.direction) {
        case JoystickDirection.left:
          myPlayer.moveLeft();
          break;
        case JoystickDirection.right:
          myPlayer.moveRight();
          break;
        default:
          myPlayer.moveNone();
      }
    }
  }

  // Function to respawn the player at the initial spawn point
  void respawnPlayer() {
    if (lives > 0) {
      lives--;
      myPlayer = Player(position: playerSpawnPoint);
      world.add(myPlayer);
      camera.follow(myPlayer);
      camera.viewfinder.position = playerSpawnPoint;

      livesText.text = 'Lives: $lives';

      // Re-enable the jump button
      jumpButton.setEnabled(true);

      isPlayerDead = false; // Reset player dead flag

      if (lives == 0) {
        isPlayerDead = true;
        jumpButton.setEnabled(false); // Disable jump button when player is dead
        showGameOver();
      }
    } else {
      resetGame();
    }
  }

  // Function to reset the game to its initial state
  void resetGame() async {
    lives = initialLives; // Reset lives to the initial value
    livesText.text = 'Lives: $lives'; // Update livesText
    level2CoinScoreReset = 0; // Reset coin score using the new variable
    coinsText.text = 'Coins: 0'; // Reset coinsText to 0

    // Remove existing game objects (player, monsters, coins, etc.)
    world.removeAll(world.children);

    // Reload the level
    await loadLevel();

    // Reinitialize UI components
    add(livesText);
    add(coinsText);
    await camera.viewport.add(joystick);
    await camera.viewport.add(jumpButton);

    // Reset the player dead flag
    isPlayerDead = false;

    // Reset and re-enable the jump button
    jumpButton.setEnabled(true);

    // Restart the background music
    FlameAudio.bgm.play("bg.mp3");
  }

  // Function to handle coin collection
  void collectCoin() {
    if (level2CoinScore < 10) {
      level2CoinScore++;
    }
    if (level2CoinScoreReset < 10) {
      level2CoinScoreReset++; // Increment the reset variable as well
    }
    coinsText.text = 'Coins: $level2CoinScoreReset';
    saveLevel2CoinScore(level2CoinScore); // Save the coin score

    if (level2CoinScoreReset >= 10) {
      unlockNextLevel(); // Unlock the next level
      showWin(); // Show win overlay when 10 coins are collected
    }
  }

  // Method to update the coin count
  void updateCoinCount(int newCoinCount) {
    level2CoinScore = newCoinCount;
    coinsText.text = 'Coins: $level2CoinScore';
  }

  // Example of updating the coin count
  void onCoinCollected() {
    updateCoinCount(level2CoinScore + 1);
  }

  Future<void> saveLevel2CoinScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('level2CoinScore', score);
  }

  Future<int?> getLevel2CoinScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('level2CoinScore');
  }

  Future<void> unlockNextLevel() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'level3Unlocked', true); // Example for unlocking level 2
  }

  Future<bool> isLevelUnlocked(int level) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('level${level}Unlocked') ?? false;
  }
}
