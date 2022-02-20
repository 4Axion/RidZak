package;

import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;

class RRSplash extends MusicBeatState
{
    override function create() {
        FlxG.sound.play(Paths.sound('RedRoyalIntro'));
        var img:FlxSprite = new FlxSprite().loadGraphic(Paths.image('img'));
        img.setGraphicSize(Std.int(img.width * 0.3));
        img.antialiasing = true;
        img.screenCenter();
        add(img);
        
        FlxTween.tween(img, {alpha: 0}, 2, {
            onComplete: function(twn:FlxTween) {
                LoadingState.loadAndSwitchState(new TitleState(), true);
            }
        });
    }
}