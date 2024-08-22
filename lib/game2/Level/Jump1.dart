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

  @override
  FutureOr<void> onLoad() async {
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
        margin: EdgeInsets.only(left: 50, bottom: 30));

    jump = JoystickComponent(
      knob: CircleComponent(),
      background: CircleComponent(
          radius: 30, paint: Paint()..color = Colors.white.withOpacity(0.50)),
      margin: EdgeInsets.only(right: 50, bottom: 30),
    );

    await camera.viewport.add(jump);
    await camera.viewport.add(joystick);

    joystick.priority = 0;
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
      // Handle player getting hit by monsters or bumpy
      // For example:
      myPlayer.removeFromParent(); // Remove the player from the game
      respawnPlayer(); // Respawn the player at the starting point
      // You can add other actions like restarting the game or showing a game over screen
    }
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
    myPlayer = Player(position: playerSpawnPoint);
    world.add(myPlayer);
    camera.follow(myPlayer);
  }
}
