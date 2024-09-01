import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cardgame/game2/components/game-ui/bumpy.dart';
import 'package:flutter_cardgame/game2/components/game-ui/ground.dart';

import 'monsters.dart';
//class ตัวละครหลัก

class Player extends SpriteAnimationComponent
    with HasGameRef, KeyboardHandler, CollisionCallbacks {
  Player({required super.position})
      : super(
            size: Vector2(60, 60), //ปรับขนาดตัวละคร
            anchor: Anchor.center); //กำหนดขนาด ใส่ค่าขนาด 2 ค่า
  late SpriteAnimation stand;
  late SpriteAnimation playerAction;
  late SpriteAnimation idle;
  late SpriteAnimation run;
  late SpriteAnimation hit;

  double moveSpeed = 300; //ความเร็ว
  int horizonDirect = 0; //เก็บค่าวิ่งไปทางไหน
  //Vector2 startingPosition = Vector2.zero();
  final Velocity = Vector2.zero(); //แรงโน้มถ่วง
  final gravitySpeed = 800;
  bool isGround = false;
  bool isJump = false;
  bool isWall = false;
  bool hasCollided = false;

  @override
  FutureOr<void> onLoad() async {
    // sprite =  await gameRef.loadSprite("2.png");
    await loadAnimation().then((_) => {animation = playerAction});

    //startingPosition = Vector2(position.x,position.y );

    add(RectangleHitbox(
      collisionType: CollisionType.active,
    ));
    //position = gameRef.size / 2;
    //debugMode = true;

    return super.onLoad();
  }

  Future<void> loadAnimation() async {
    //final imgIdle =  await gameRef.images.load("2.png");
    run = SpriteAnimation.fromFrameData(
      await gameRef.images.load("monkRun.png"),
      SpriteAnimationData.sequenced(
        amount: 8,
        stepTime: 0.1,
        textureSize: Vector2(32, 32),
      ),
    );

    idle = SpriteAnimation.fromFrameData(
      await gameRef.images.load("monkIdle.png"),
      SpriteAnimationData.sequenced(
        amount: 18,
        stepTime: 0.2,
        textureSize: Vector2(32, 32),
      ),
    );

    hit = SpriteAnimation.fromFrameData(
      await gameRef.images.load("monkHit.png"),
      SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: 0.2,
        textureSize: Vector2(32, 32),
      ),
    );
    playerAction = idle;
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // horizonDirect = 0;
    // horizonDirect += (keysPressed.contains(LogicalKeyboardKey.keyA)) ? -1 : 0;
    // horizonDirect += (keysPressed.contains(LogicalKeyboardKey.keyD)) ? 1 : 0;

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    super.update(dt); //dt เป็นเฟรมเลส

    Velocity.x = horizonDirect * moveSpeed;

    if (!isGround) {
      Velocity.y += gravitySpeed * dt;
    }

    if (isWall) {
      Velocity.x = 0;
    }

    position += Velocity * dt;

    if ((horizonDirect < 0 && scale.x > 0) ||
        (horizonDirect > 0 && scale.x < 0)) {
      flipHorizontally();
    }

    // if ((horizonDirect < 0 && scale.x < 0) ||
    //     (horizonDirect > 0 && scale.x > 0)) {
    //   flipHorizontally();
    // }

    updateAnimation();
  }

  void updateAnimation() {
    animation = (horizonDirect == 0) ? idle : run;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    //เจอมอนสเตอร์
    if (other is Monsters || other is Bumpy) {
      hasCollided = true;
    }
    // เจอพื้นหรือกำแพง
    if (other is GroundBlock) {
      //เจอพื้น
      if (other.position.y > position.y) {
        Velocity.y = 0;
        isGround = true;
        position.y = other.position.y - size.y / 2;
        isJump = false;
      } else {
        if (isJump) {
          if (other.x + other.size.x - 10 < position.x) {
            //ชนทางซ้าย
            position.x = other.x + other.size.x + 20;
          } else {
            if (other.x <= position.x) {
              //ชนจากข้างล่าง
              Velocity.y = -Velocity.y;
            } else {
              //ชนทางขวา
              position.x = other.x - 30;
            }
          }
        } else {
          Velocity.x = 0;
          if (other.x < position.x - size.x) {
            //ชนทางซ้าย
            position.x = other.x + other.size.x + 30;
          } else {
            //ชนทางขวา
            position.x = other.x - 30;
          }
        }
      }
    }
    if (other is Bumpy) {
      // other.removeFromParent();
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    // TODO: implement onCollisionEnd
    super.onCollisionEnd(other);
    if (isGround) {
      isGround = false;
    }
    if (isWall) {
      isWall = false;
    }
  }

  void moveJump() {
    Velocity.y = (-gravitySpeed / 2);
    isJump = true;
    isGround = false;
  }

  void moveLeft() {
    horizonDirect = -1;
  }

  void moveRight() {
    horizonDirect = 1;
  }

  void moveNone() {
    horizonDirect = 0;
  }
}
