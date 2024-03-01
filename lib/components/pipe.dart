import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:new_flappybird/game/assets.dart';
import 'package:new_flappybird/game/configuration.dart';
import 'package:new_flappybird/game/flappybirdgame.dart';
import 'package:new_flappybird/game/pipeposition.dart';

class Pipe extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  Pipe({
    required this.pipePosition,
    required this.height,
    required this.xpos,
  });

  @override
  final double xpos;
  final double height;
  final PipePosition pipePosition;

  @override
  Future<void> onLoad() async {
    final pipe = await Flame.images.load(Assets.imgPipe);
    final pipeRotated = await Flame.images.load(Assets.imgPipeRotated);
    size = Vector2(50, height);
    position.x = xpos;

    switch (pipePosition) {
      case PipePosition.top:
        position.y = 0;
        sprite = Sprite(pipeRotated);
        break;
      case PipePosition.bottom:
        position.y = gameRef.size.y - size.y - Config.groundHeight;
        sprite = Sprite(pipe);
        break;
    }

    add(RectangleHitbox());

  }
}
