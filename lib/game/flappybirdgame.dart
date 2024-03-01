import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:new_flappybird/components/background.dart';
import 'package:new_flappybird/components/bird.dart';
import 'package:new_flappybird/components/ground.dart';
import 'package:new_flappybird/components/pipegroup.dart';
import 'package:new_flappybird/game/configuration.dart';
import 'package:new_flappybird/game/score.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();

  late Score score;
  late Bird bird;
  late double interval = 0;
  late bool isRestarted = false;

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      PipeGroup(),
      bird = Bird(),
      score = Score(),
    ]);
  }

  @override
  void onTap() {
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);

    interval += dt;
    if (interval > Config.dPipeInterval) {
      interval = 0;
      add(PipeGroup());
    }
  }
}
