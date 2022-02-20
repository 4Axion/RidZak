package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class PaperView extends MusicBeatState
{
    var canPress:Bool = false;
    var msgtxt:FlxText;
    var page:FlxSprite;
    var coolY:Float;
    override function create()
        {
            var tempy:Float;
            page = new FlxSprite(0,-1800).loadGraphic(Paths.image('paper'));
            page.antialiasing = ClientPrefs.globalAntialiasing;
            page.setGraphicSize(Std.int(page.width * 0.44));
            page.updateHitbox();
            tempy = page.y;
            page.screenCenter();
            coolY = page.y;
            page.y = tempy;
            add(page);

            new FlxTimer().start(0.9, function(tmr:FlxTimer) {
                FlxTween.tween(page, {y: coolY}, 0.5, {ease: FlxEase.quadInOut});
            });

            msgtxt = new FlxText(0, 0, FlxG.width, 'Press Anything To Continue..', 20);
            msgtxt.setFormat(Paths.font("Bubblegum.ttf"), 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            msgtxt.scrollFactor.set();
            msgtxt.borderSize = 1.25;
            msgtxt.alpha = 0;
            add(msgtxt);

            new FlxTimer().start(3, function(tmr:FlxTimer) {
                canPress = true;
                doFade();
            });
            super.create();
        }

    override function update(elapsed:Float)
        {
            if (FlxG.keys.justPressed.ANY && canPress)
                {
                    canPress = false;
                    FlxG.sound.play(Paths.sound('PageFlip'), 0.7);
                    FlxTween.tween(page, {y: 1000}, 0.5, {
                        ease: FlxEase.quadInOut,
                        onComplete: function(twn:FlxTween) {
                            LoadingState.loadAndSwitchState(new PlayState());
                        }
                    });
                }
            super.update(elapsed);
        }

        function doFade()
            {
                FlxTween.tween(msgtxt, {alpha: 1}, 1, {
                    ease: FlxEase.quadInOut,
                    onComplete: function(twn:FlxTween) {
                        FlxTween.tween(msgtxt, {alpha: 0}, 1, {
                            ease: FlxEase.quadInOut,
                            onComplete: function(twn:FlxTween) {
                                doFade();
                            }
                        });
                    }
                });
            }
}