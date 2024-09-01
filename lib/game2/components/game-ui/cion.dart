import 'package:flame_audio/flame_audio.dart';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'player.dart';



class Cion extends SpriteAnimationComponent
    with HasGameRef, KeyboardHandler, CollisionCallbacks {
  Cion({required super.position})
      : super(
            size: Vector2(40, 40), //ปรับขนาดตัวละคร
            anchor: Anchor.center); //กำหนดขนาด ใส่ค่าขนาด 2 ค่า

  late SpriteAnimation stand;
  late SpriteAnimation playerAction;
  late SpriteAnimation idle;
  late SpriteAnimation run;
  double moveSpeed = 300; //ความเร็ว
  int horizonDirect = 0; //เก็บค่าวิ่งไปทางไหน
  // ignore: non_constant_identifier_names
  final Velocity = Vector2.zero(); //แรงโน้มถ่วง
  final gravitySpeed = 800;
  bool isCion = false;
  bool isJump = false;
  bool isWall = false;

  Future<void> onLoad() async {
    await loadAnimation().then((_) => {animation = playerAction});
    add(RectangleHitbox(
      collisionType: CollisionType.active,
    ));
    //position = gameRef.size / 2;
    //debugMode = true;

    

    return super.onLoad();
  }

  Future<void> loadAnimation() async {
    idle = SpriteAnimation.fromFrameData(
      await gameRef.images.load("coin64x64.png"),
      SpriteAnimationData.sequenced(
        amount: 25,
        stepTime: 0.1,
        textureSize: Vector2(64, 64),
      ),
    );
    playerAction = idle;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if(other is Player){
      FlameAudio.play("pickupCoin.wav");//เสียงเหรียญ
      removeFromParent();//ลบmonsterเมื่อโดนชน
    }
  }
}
