import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:new_flappybird/game/assets.dart';
import 'package:new_flappybird/game/flappybirdgame.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  Background();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(Assets.imgBackgorund);
    size = gameRef.size; //Vector2(gameRef.size.x, gameRef.size.y);
    sprite = Sprite(background);
  }
}
