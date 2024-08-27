// ignore: file_names
import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
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
  late Vector2 playerSpawnPoint;

  int lives = 2;
  int initialLives = 2;

  late TextComponent livesText;

  bool isPlayerDead = false;

  @override
  FutureOr<void> onLoad() async {
    initialLives = lives;

    _initializeLivesText();
    await _loadBackground();
    await _loadLevel();
    _initializeJoystick();
    _registerGameOverOverlay();

    return super.onLoad();
  }

  void _initializeLivesText() {
    livesText = TextComponent(
      text: 'Lives: $lives',
      position: Vector2(size.x - 10, 10),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 0, 0),
          fontSize: 20,
        ),
      ),
    );
    camera.viewport.add(livesText);
  }

  Future<void> _loadBackground() async {
    background = SpriteComponent()
      ..sprite = await loadSprite('bg2.gif')
      ..size = size;
    add(background);
  }

  Future<void> _loadLevel() async {
    final level = await TiledComponent.load("map.tmx", Vector2.all(32));
    overlays.add('BackButton');
    FlameAudio.bgm.stop();

    mapWidth = (level.tileMap.map.width * level.tileMap.destTileSize.x).toInt();
    mapHeight = (level.tileMap.map.height * level.tileMap.destTileSize.y).toInt();
    world.add(level);

    _loadSpawnPoints(level);
    _loadCoins(level);
    _loadMonsters(level);
    _loadGround(level);

    camera.setBounds(
      Rectangle.fromLTRB(size.x / 2, size.y / 2.4, level.width - size.x / 2, level.height - size.y / 2),
    );
    camera.viewfinder.anchor = Anchor.center;
  }

  void _loadSpawnPoints(TiledComponent level) {
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>("spawn");
    for (final spawnPoint in spawnPointsLayer!.objects) {
      if (spawnPoint.class_ == "player") {
        playerSpawnPoint = spawnPoint.position;
        myPlayer = Player(position: spawnPoint.position);
        world.add(myPlayer);
        camera.follow(myPlayer);
        FlameAudio.bgm.play("bg.mp3");
      }
    }
  }

  void _loadCoins(TiledComponent level) {
    final coinPointsLayer = level.tileMap.getLayer<ObjectGroup>("coin");
    for (final coinPoint in coinPointsLayer!.objects) {
      if (coinPoint.class_ == "coin") {
        myCoin = Cion(position: coinPoint.position);
        world.add(myCoin);
      }
    }
  }

  void _loadMonsters(TiledComponent level) {
    final monstersPointsLayer = level.tileMap.getLayer<ObjectGroup>("monsters");
    for (final monstersPoint in monstersPointsLayer!.objects) {
      if (monstersPoint.class_ == "monsters") {
        monsters = Monsters(position: monstersPoint.position);
        world.add(monsters);
      } else if (monstersPoint.class_ == "bumpy") {
        final bumpy = Bumpy(position: monstersPoint.position);
        world.add(bumpy);
      }
    }
  }

  void _loadGround(TiledComponent level) {
    final groundLayer = level.tileMap.getLayer<ObjectGroup>("ground");
    for (final groundPoint in groundLayer!.objects) {
      final ground = GroundBlock(position: groundPoint.position, size: groundPoint.size);
      world.add(ground);
    }
  }

  void _initializeJoystick() {
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 40, paint: Paint()..color = Colors.redAccent.withOpacity(0.50)),
      background: CircleComponent(radius: 50, paint: Paint()..color = Colors.white.withOpacity(0.50)),
      margin: const EdgeInsets.only(left: 50, bottom: 30),
    );

    jump = JoystickComponent(
      knob: CircleComponent(),
      background: CircleComponent(radius: 30, paint: Paint()..color = Colors.white.withOpacity(0.50)),
      margin: const EdgeInsets.only(right: 50, bottom: 30),
    );

    camera.viewport.add(jump);
    camera.viewport.add(joystick);
    joystick.priority = 0;
  }

  void _registerGameOverOverlay() {
    overlays.addEntry(
      'GameOver',
      (context, game) => GameOverOverlay(
        onRestart: restartGame,
      ),
    );
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
    _updateJoystick();

    if (myPlayer.hasCollided) {
      myPlayer.removeFromParent();
      _respawnPlayer();
    }

    camera.follow(myPlayer);
  }

  void _updateJoystick() {
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

  @override
  void onResize(Vector2 size) {
    camera.viewport = FixedResolutionViewport(resolution: size);
  }

  void _respawnPlayer() {
    if (lives > 0) {
      lives--;
      myPlayer = Player(position: playerSpawnPoint);
      world.add(myPlayer);
      camera.follow(myPlayer);
      camera.viewfinder.position = playerSpawnPoint;
      livesText.text = 'Lives: $lives';

      if (lives == 0) {
        isPlayerDead = true;
        showGameOver();
      }
    } else {
      _resetGame();
    }
  }

  void showGameOver() {
    overlays.add('GameOver');
  }

  void restartGame() {
    overlays.remove('GameOver');
    _respawnPlayer();
  }

  void _resetGame() {
    lives = initialLives;
    livesText.text = 'Lives: $lives';
    world.removeAll(world.children);
    onLoad();
    overlays.remove('GameOver');
    isPlayerDead = false;
  }
}