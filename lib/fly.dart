import 'dart:ui';
import 'package:langaw/langaw-game.dart';// Access to screen size
import 'package:langaw/rain.dart';
import 'package:langaw/view.dart';
import 'package:flame/sprite.dart';
import 'package:langaw/render_power.dart';

// Rect instances are immutable. However its shift and translate methods can be used to move it.
class Fly{
  final LangawGame game;
  Rect flyRect;
//  Paint flyPaint;
  bool isLeft = false;
  bool extra_live = false;
  bool isRight = false;
  bool isUp = false;
  double x;
  double y;
  int pixel_pos = 0;
  Sprite ball;
  int pos;

  Fly(this.game, this.x, this.y) {
    ball = Sprite('circle.png');
    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
//    flyPaint = Paint();
//    flyPaint.color = Color(0xff6ab04c);
  }

  void render(Canvas c) {
    if(game.smallActive == false){
      ball.renderRect(c, flyRect);
    }else{
      ball.renderRect(c, flyRect.deflate(10));
    }
  }

  void update(double t) {
    if (isLeft) {
      if (x >= game.tileSize){
        x += (game.tileSize * -7 * t);
        flyRect = flyRect.translate(game.tileSize * -7 * t, 0);
      }
    }
    if (isRight) {
      if (x <= game.screenSize.width - (game.tileSize * 2)){
        x += (game.tileSize * 7 * t);
        flyRect = flyRect.translate(game.tileSize * 7 * t, 0);
      }
    }
    if(extra_live){
      pos = 3;
    }
    else{
      pos = 2;
    }
    if (isUp && game.shieldActive == false){
      if (pixel_pos < pos) {
        pixel_pos += 1;
        y += game.tileSize * -2;
        flyRect = flyRect.translate(0, game.tileSize * -2);
        isUp = false;
      }
      else{
        game.activeView = View.lost;
        game.power_up = List<Powers>();
        game.rains = List<Rain>();
        game.amountRain = 1;
        pixel_pos = 0;
        isUp = false;
        isLeft = false;
        game.smallActive = false;
        isRight = false;
        game.heart_add = true;
        game.firstFree = true;
        game.secondFree = true;
        game.thirdFree = true;
        if(game.heart_bought){
          y += game.tileSize * 6;
          flyRect = flyRect.translate(0, game.tileSize * 6);
          game.heart_pixel_add = true;
          extra_live = true;
        }
        else{
          y += game.tileSize * 4;
          flyRect = flyRect.translate(0, game.tileSize * 4);
        }
      }
    }
    if (isUp && game.shieldActive){
      isUp = false;
    }
  }
}