package;

import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class PixelMenu extends MusicBeatState
{
    var gmovrtxt:FlxText;
    var continuetxt:FlxText;
    var quittxt:FlxText;
    var curSelected:Bool = true;
	var camOther:FlxCamera;
	var hasLoaded:Bool = false;
    var loadingtxt:FlxText;
    var loadingbg:FlxSprite;
    public static var info:Array<String> = ['Minus RidZak Unlocked!','Code Room','Crazy Collab Crossover'];
    override function create()
        {
            camOther = new FlxCamera();
            FlxG.cameras.add(camOther);

            FlxG.camera.zoom = arcade.PixelState.arcadeZoom;

            gmovrtxt = new FlxText(0, 240, FlxG.width, info[0], 60);
            gmovrtxt.setFormat(Paths.font("arcade.ttf"), 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            gmovrtxt.scrollFactor.set();
            gmovrtxt.borderSize = 2.25;
            gmovrtxt.screenCenter(X);
            add(gmovrtxt);

            continuetxt = new FlxText(0, gmovrtxt.y + gmovrtxt.height+18, FlxG.width, info[1], 60);
            continuetxt.setFormat(Paths.font("arcade.ttf"), 36, 0xFF0030cc, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            continuetxt.scrollFactor.set();
            continuetxt.borderSize = gmovrtxt.borderSize-1;
            continuetxt.screenCenter(X);
            add(continuetxt);

            quittxt = new FlxText(0, continuetxt.y + continuetxt.height+18, FlxG.width, info[2], 60);
            quittxt.setFormat(Paths.font("arcade.ttf"), 36, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            quittxt.scrollFactor.set();
            quittxt.borderSize = continuetxt.borderSize;
            quittxt.screenCenter(X);
            add(quittxt);

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
                        {
                            loadState(info[1]);
                        }
                    else
                        {
                            loadState(info[2]);
                        }
                }
            super.update(elapsed);
        }
        function loadState(lestate:String)
            {
                switch(lestate)
                {
                    case 'Code Room':
                        FlxG.sound.playMusic(Paths.music('doorsMus'));
                        FlxG.switchState(new CodeShit());
                    case 'Crazy Collab Crossover':
                        FlxG.sound.playMusic(Paths.music('freakyMenuINTRO'));
                        FlxG.switchState(new CCCList());
                    case 'Freeplay':
                        FlxG.sound.playMusic(Paths.music('freakyMenuINTRO'));
                        FlxG.switchState(new FreeplayState());
                }
            }
        public static function cancelMusicFadeTween() {
            if(FlxG.sound.music.fadeTween != null) {
                FlxG.sound.music.fadeTween.cancel();
            }
            FlxG.sound.music.fadeTween = null;
        }
}