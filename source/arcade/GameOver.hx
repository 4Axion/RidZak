package arcade;

import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class GameOver extends MusicBeatState
{
    var gmovrtxt:FlxText;
    var continuetxt:FlxText;
    var quittxt:FlxText;
    var curSelected:Bool = true;
	var camOther:FlxCamera;
	var hasLoaded:Bool = false;
    var loadingtxt:FlxText;
    var loadingbg:FlxSprite;
    override function create()
        {
            camOther = new FlxCamera();
            FlxG.cameras.add(camOther);

            FlxG.camera.zoom = PixelState.arcadeZoom+PixelState.amounless;

            gmovrtxt = new FlxText(0, 240, FlxG.width, 'Game Over', 60);
            gmovrtxt.setFormat(Paths.font("arcade.ttf"), 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            gmovrtxt.scrollFactor.set();
            gmovrtxt.borderSize = 2.25;
            gmovrtxt.screenCenter(X);
            add(gmovrtxt);

            continuetxt = new FlxText(0, gmovrtxt.y + gmovrtxt.height+18, FlxG.width, 'Continue?', 60);
            continuetxt.setFormat(Paths.font("arcade.ttf"), 36, 0xFF0030cc, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            continuetxt.scrollFactor.set();
            continuetxt.borderSize = gmovrtxt.borderSize-1;
            continuetxt.screenCenter(X);
            add(continuetxt);

            quittxt = new FlxText(0, continuetxt.y + continuetxt.height+18, FlxG.width, 'Quit', 60);
            quittxt.setFormat(Paths.font("arcade.ttf"), 36, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            quittxt.scrollFactor.set();
            quittxt.borderSize = continuetxt.borderSize;
            quittxt.screenCenter(X);
            add(quittxt);
            
            var overlayArcade:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Arcade', 'arcade'));
            overlayArcade.antialiasing = ClientPrefs.globalAntialiasing;
            overlayArcade.setGraphicSize(Std.int(1280), Std.int(720));
            overlayArcade.updateHitbox();
            overlayArcade.screenCenter();
            add(overlayArcade);

            /*loadingbg = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
            loadingbg.antialiasing = ClientPrefs.globalAntialiasing;
            loadingbg.setGraphicSize(1280, 720);
            loadingbg.updateHitbox();
            add(loadingbg);

            loadingtxt = new FlxText(0, 180, FlxG.width, 'Loading..', 60);
            loadingtxt.setFormat(Paths.font("arcade.ttf"), 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            loadingtxt.scrollFactor.set();
            loadingtxt.borderSize = 2.25;
            loadingtxt.screenCenter(X);
            add(loadingtxt);*/

            super.create();
        }

    override function update(elapsed)
        {
            if (controls.UI_UP_P || controls.UI_DOWN_P)
                {
                    curSelected = !curSelected;
                    continuetxt.color = FlxColor.WHITE;
                    quittxt.color = FlxColor.WHITE;
                    if (curSelected)
                        continuetxt.color = 0xFF0030cc;
                    else
                        quittxt.color = 0xFF0030cc;
                }
            if (controls.ACCEPT)
                {
                    FlxG.sound.music.stop();
					CustomFadeTransition.nextCamera = camOther;
                    if (curSelected)
                        FlxG.switchState(new arcade.PixelState());
                    else
                        FlxG.switchState(new CodeShit());
                }
            super.update(elapsed);
        }
        public static function cancelMusicFadeTween() {
            if(FlxG.sound.music.fadeTween != null) {
                FlxG.sound.music.fadeTween.cancel();
            }
            FlxG.sound.music.fadeTween = null;
        }
}