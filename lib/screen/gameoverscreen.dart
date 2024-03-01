import 'package:flutter/material.dart';
import 'package:new_flappybird/game/assets.dart';
import 'package:new_flappybird/game/flappybirdgame.dart';

class GameoverScreen extends StatelessWidget {
  final FlappyBirdGame game;
  static const String id = 'gameOver';

  const GameoverScreen({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.black38,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Score: ${game.score.score}',
                style: const TextStyle(
                  fontSize: 55,
                  color: Colors.white,
                  fontFamily: 'Game',
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(Assets.imgGameOver),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onRestart,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  '새로시작',
                  style: TextStyle(
                    fontSize: 20, 
                    color: Colors.white,
                    // fontFamily: 'Game',
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void onRestart() {
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
