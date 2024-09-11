import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import 'player.dart';


class Medusa extends SpriteAnimationComponent with HasGameRef ,CollisionCallbacks {
  Medusa({required super.position})
      : super(
            size: Vector2(100, 100), //ปรับขนาดตัวละคร
            anchor: Anchor.center); //กำหนดขนาด ใส่ค่าขนาด 2 ค่า

      late SpriteAnimation action;

      late SpriteAnimation idle;
      late SpriteAnimation attack;

      final bool isVertical = false;
      final double offNeg = 7;
      final double offPos = 7;
      static const tilesize = 32;
      double moveDirection = 1;
      double moveSpeed = 50;
      double rangeNeg = 0;
      double rangePos = 0;



  @override
  FutureOr<void> onLoad() async{

     await loadAnimation().then((_) => {animation = action});
    add(RectangleHitbox(collisionType: CollisionType.active,));

    priority = -1;
    // debugMode = true;

    if(isVertical){
      rangeNeg = position.y - offNeg * tilesize;
      rangePos = position.y + offPos * tilesize;
    }else{
      rangeNeg = position.x - offNeg * tilesize;
      rangePos = position.x + offPos * tilesize;
    }
    return super.onLoad();
  }

    Future<void> loadAnimation() async {
   
    idle = SpriteAnimation.fromFrameData(
      await gameRef.images.load("medusa.png"),
      SpriteAnimationData.sequenced(
        amount: 7,
        stepTime: 0.2,
        textureSize: Vector2(128, 128),
      ),
    );
    action = idle;
  }

 

  @override
  void update(double dt) {
    // position.x += moveDirection * moveSpeed * dt;
    if(isVertical){
      _moveVertically(dt);
    }else{
      _moveHorizontally(dt);
    }
    super.update(dt);
  }
  
  void _moveVertically(double dt) {
    if(position.y >= rangePos){
      moveDirection = -1;
    }else if(position.y <= rangeNeg){
      moveDirection = 1;
    }
    position.y += moveDirection * moveSpeed * dt;
  }//monster เลื่อนขึ้นลง
  
  void _moveHorizontally(double dt) {
    if(position.x >= rangePos){
      moveDirection = -1;
    }else if(position.x <= rangeNeg){
      moveDirection = 1;
    }
    position.x += moveDirection * moveSpeed * dt;

    if ((moveDirection < 0 && scale.x > 0) ||
        (moveDirection > 0 && scale.x < 0)) {
      flipHorizontally();
    }
  }//monster เดินไปมา

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);

    if(other is Player){
      FlameAudio.play("hit.wav");
      // removeFromParent();//ลบmonsterเมื่อโดนชน
    }
  }
}
