
import 'package:flame_audio/flame_audio.dart';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_cardgame/game2/components/game-ui/player.dart';


class Monsters extends SpriteAnimationComponent with HasGameRef, KeyboardHandler,CollisionCallbacks{
  Monsters({required super.position}):super (size: Vector2(100, 100),//ปรับขนาดตัวละคร
            anchor: Anchor.center); //กำหนดขนาด ใส่ค่าขนาด 2 ค่า

  late SpriteAnimation stand;
  late SpriteAnimation playerAction;
  late SpriteAnimation idle;
  late SpriteAnimation run;


  Future<void> onLoad()async{
     await loadAnimation().then((_) => {animation = playerAction});
    add(RectangleHitbox(collisionType: CollisionType.active,));
    //position = gameRef.size / 2;
    //debugMode = true;

    return super.onLoad();
  }

  Future<void> loadAnimation() async {
   
    idle = SpriteAnimation.fromFrameData(
      await gameRef.images.load("medusa.png"),
      SpriteAnimationData.sequenced(
        amount: 7,
        stepTime: 0.3,
        textureSize: Vector2(128, 128),
      ),
    );
    playerAction = idle;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
     if(other is Player){
      FlameAudio.play("hit.wav");//เสียงชน
      removeFromParent();//ลบmonsterเมื่อโดนชน
    }
  }
}