import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_flappybird/game/flappybirdgame.dart';
import 'package:new_flappybird/screen/gameoverscreen.dart';
import 'package:new_flappybird/screen/mainmenuscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final game = FlappyBirdGame();
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) =>   
      runApp(
        GameWidget(
          game: game,
          initialActiveOverlays: const [MainmenuScreen.id],
          overlayBuilderMap: {
            'mainMenu': (context, _) => MainmenuScreen(game: game),
            'gameOver': (context, _) => GameoverScreen(game: game),
          },                     
        
        ),

        
      )
  );

}

