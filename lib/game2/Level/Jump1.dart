import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cardgame/game2/components/bumpy.dart';
import 'package:flutter_cardgame/game2/components/cion.dart';
import 'package:flutter_cardgame/game2/components/game_over_overlay.dart';
import 'package:flutter_cardgame/game2/components/ground.dart';
import 'package:flutter_cardgame/game2/components/monsters.dart';
import 'package:flutter_cardgame/game2/components/player.dart';

class Jump1 extends FlameGame
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

  late TextComponent livesText; // Declare a TextComponent for lives

  @override
  FutureOr<void> onLoad() async {
    initialLives = lives; // Initialize initialLives in onLoad

    // Initialize livesText
    livesText = TextComponent(
      text: 'Lives: $lives',
      position: Vector2(10, 10), // Adjust position as needed
      anchor: Anchor.topLeft, // Align text to top-left
      textRenderer: TextPaint(
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
    camera.viewport.add(livesText); // Add livesText to the camera viewport

    // Load the GIF background
    background = SpriteComponent()
      ..sprite = await loadSprite('bg2.gif')
      ..size = size;

    // Add the background to the game world
    add(background);

    final level = await TiledComponent.load(
      "map.tmx",
      Vector2.all(32),
    );

    overlays.add('BackButton');
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
          camera.follow(myPlayer);
          break;
      }
      FlameAudio.bgm.play(
        "bg.mp3",
      );
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
      }
    }

    final groundLayer = level.tileMap.getLayer<ObjectGroup>("ground");
    for (final groundPoint in groundLayer!.objects) {
      final grounds =
          GroundBlock(position: groundPoint.position, size: groundPoint.size);
      world.add(grounds);
    }

    // Use a camera component that adjusts to the screen size
    camera = CameraComponent(
      world: world,
    );

    // Set the camera zoom to fit the map height to the screen height
    final screenSize = size; // Get the screen size
    final zoomFactor = screenSize.y / mapHeight;
    camera.viewfinder.zoom = zoomFactor;

    camera.viewfinder.anchor = Anchor.topLeft;

    joystick = JoystickComponent(
        knob: CircleComponent(
            radius: 40, paint: Paint()..color = Colors.white.withOpacity(0.50)),
        background: CircleComponent(
            radius: 50, paint: Paint()..color = Colors.white.withOpacity(0.50)),
        margin: const EdgeInsets.only(left: 50, bottom: 30));

    jump = JoystickComponent(
      knob: CircleComponent(),
      background: CircleComponent(
          radius: 30, paint: Paint()..color = Colors.white.withOpacity(0.50)),
      margin: const EdgeInsets.only(right: 50, bottom: 30),
    );

    await camera.viewport.add(jump);
    await camera.viewport.add(joystick);

    joystick.priority = 0;

    // Register the game over overlay
    overlays.addEntry(
      'GameOver',
      (context, game) => GameOverOverlay(
        onRestart: restartGame,
      ),
    );

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) async {
    super.onTapUp(event);
    myPlayer.moveJump();
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
  }

  void showGameOver() {
    overlays.add('GameOver');
  }

  void restartGame() {
    overlays.remove('GameOver');
    respawnPlayer();
  }

  updateJoystrick() {
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

  @override
  void onResize(Vector2 size) {
    // Update camera or other components based on the new screen size
    // For example:
    camera.viewport = FixedResolutionViewport(
      resolution: size,
    );
  }


  // Function to respawn the player at the initial spawn point
  void respawnPlayer() {
    if (lives > 0) {
      lives--;
      myPlayer = Player(position: playerSpawnPoint);
      world.add(myPlayer);
      camera.follow(myPlayer);
      camera.viewfinder.position = playerSpawnPoint;

      // Update livesText whenever lives change
      livesText.text = 'Lives: $lives';

      if (lives == 0) {
        showGameOver(); // Show game over when lives reach 0
      }
    } else {
      resetGame(); // Call resetGame when lives reach 0
    }
  }

  // Function to reset the game to its initial state
  void resetGame() {
    lives = initialLives; // Reset lives to the initial value
    livesText.text = 'Lives: $lives'; // Update livesText

    // Remove existing game objects (player, monsters, coins, etc.)
    world.removeAll(world.children);

    // Reload the game world (add player, monsters, coins, etc.)
    onLoad(); // You might need to modify onLoad to handle resetting properly

    // Remove the Game Over overlay
    overlays.remove('GameOver');
  }
}
