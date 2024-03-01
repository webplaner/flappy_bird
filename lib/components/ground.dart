import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:new_flappybird/game/assets.dart';
import 'package:new_flappybird/game/configuration.dart';
import 'package:new_flappybird/game/flappybirdgame.dart';

class Ground extends ParallaxComponent<FlappyBirdGame> {
  Ground();

  @override
  Future<void> onLoad() async {
    final ground = await Flame.images.load(Assets.imgGround);
    // size = gameRef.size; //Vector2(gameRef.size.x, gameRef.size.y);
    // sprite = Sprite(background);

    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(ground, fill: LayerFill.none),
      ),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = Config.gameSpeed;
  }
}
