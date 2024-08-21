import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class GroundBlock extends PositionComponent with CollisionCallbacks{
  GroundBlock ({required super.position,super.size});
  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(collisionType: CollisionType.passive));
   // debugMode = true;
    return super.onLoad();
  }
}