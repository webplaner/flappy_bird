import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:new_flappybird/game/assets.dart';
import 'package:new_flappybird/game/birdmovement.dart';
import 'package:new_flappybird/game/configuration.dart';
import 'package:new_flappybird/game/flappybirdgame.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Bird();

  late bool isMiddle = true;
  late double chkTime = 0;

  @override
  Future<void> onLoad() async {
    final birdMidFlap = await gameRef.loadSprite(Assets.imgBirdMidFlap);
    final birdUpFlap = await gameRef.loadSprite(Assets.imgBirdUpFlap);
    final birdDownFlap = await gameRef.loadSprite(Assets.imgBirdDownFlap);

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    current = BirdMovement.middle;
    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.down: birdDownFlap,
    };

    addAll([
      CircleHitbox(),
      MoveByEffect(
        Vector2(0, Config.gravity / 10),
        EffectController(duration: 0.12, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
      ),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gameRef.isRestarted) {
      return;
    }

    position.y += Config.birdVelocity * dt;

    if (position.y <= -1 * size.y * 0.1 ||
        position.y > gameRef.size.y - Config.groundHeight - size.y * 0.9) {
      gameOver();
    }
  }

  void fly() {
    isMiddle = false;

    add(
      MoveByEffect(
        Vector2(0, Config.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
      ),
    );

    FlameAudio.play(Assets.sndFlying);
    current = BirdMovement.up;
  }

  void gameOver() {
    if (gameRef.isRestarted) {
      return;
    }

    FlameAudio.play(Assets.sndCollision);
    gameRef.isRestarted = true;
    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
  }

  void reset() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    gameRef.score.score = 0;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    gameOver();
  }
}
