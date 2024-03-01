import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:new_flappybird/components/pipe.dart';
import 'package:new_flappybird/game/assets.dart';
import 'package:new_flappybird/game/configuration.dart';
import 'package:new_flappybird/game/flappybirdgame.dart';
import 'package:new_flappybird/game/pipeposition.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();

  final _random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    late double levelGuide = 0.3;
    // final drandom = _random.nextDouble();
    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final spacing =
        (1 + levelGuide * _random.nextDouble()) * Config.pipeSpacing;
    final tmpHeight =
        (levelGuide + _random.nextDouble()) * (heightMinusGround - spacing) / 2;
    final topHeight; // = (0.05 + _random.nextDouble()) * (heightMinusGround*0.8 - spacing);
    final bottomHeight; // = heightMinusGround - topHeight - spacing;

    if (_random.nextInt(2) == 0) {
      topHeight = tmpHeight;
      bottomHeight = heightMinusGround - topHeight - spacing;
    } else {
      bottomHeight = tmpHeight;
      topHeight = heightMinusGround - bottomHeight - spacing;
    }

    addAll([
      Pipe(pipePosition: PipePosition.top, height: topHeight, xpos: 0),
      Pipe(pipePosition: PipePosition.bottom, height: bottomHeight, xpos: 0),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x -= Config.gameSpeed * dt;

    if (position.x <= -1000) {
      // debugPrint('$position.x');
      removeFromParent();
      if (gameRef.isRestarted) {
        gameRef.isRestarted = false;
      } 
    }

    if (position.x < -100) {
      // debugPrint('$position.x');
      removeFromParent();
      if (!gameRef.isRestarted) {
        updateScore();
      }
    }

    if (gameRef.isRestarted) {
      position.x = -1000;
    }
  }

  void updateScore() {
    gameRef.score.score += 1;
    FlameAudio.play(Assets.sndPoint);
  }
}
