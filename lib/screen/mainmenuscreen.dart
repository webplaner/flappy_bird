import 'package:flutter/material.dart';
import 'package:new_flappybird/game/assets.dart';
import 'package:new_flappybird/game/flappybirdgame.dart';

class MainmenuScreen extends StatelessWidget {
  final FlappyBirdGame game;
  static const String id = 'mainMenu';  

  const MainmenuScreen({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          game.overlays.remove('mainMenu');
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imgMenu),
              fit: BoxFit.cover,
            ),
          ),
          child: Image.asset(Assets.imgMessage),
        ),
      ),
    );
  }
}