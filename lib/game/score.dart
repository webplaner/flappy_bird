import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:new_flappybird/game/flappybirdgame.dart';

class Score extends TextComponent with HasGameRef<FlappyBirdGame> {
  Score();

  late int score;
  late int gameLevel;

  @override
  Future<void>? onLoad() async {
    score = 0;
    gameLevel = 1;

    text = (score >= 0) ? score.toString() : '';
    position = Vector2(gameRef.size.x - 60, gameRef.size.y * 0.07);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    text =  score.toString();
  }

  @override
  void render(Canvas canvas) {
    TextPaint(
      style: const TextStyle(
        fontSize: 40.0,
        color: Colors.white,
        fontFamily: 'Game',
      ),
    ).render(canvas, text, Vector2.zero());
  }
}
