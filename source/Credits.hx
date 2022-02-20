package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxSprite;
import flixel.FlxG;

class Credits extends MusicBeatState
{
	var camFollow:FlxObject;
	var overlayCorner:FlxSprite;
	var bgcubes:FlxBackdrop;
	public static var curSelected:Int = 0;
	var menuItems:FlxTypedGroup<FlxText>;
	var caps:FlxTypedGroup<FlxSprite>;
	var blackOverlay:FlxSprite;
    var creditsInfo:Array<String>;
    var creditColors:Array<FlxColor> = [];
    override function create()
        {
            var bg:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('Menu New/BACK', 'ridzak'));
            bg.scrollFactor.x = 0;
            bg.scrollFactor.y = 0;
            bg.setGraphicSize(Std.int(bg.width * 1.1));
            bg.updateHitbox();
            bg.screenCenter();
            bg.y -= 50;
            bg.antialiasing = true;
            add(bg);

            camFollow = new FlxObject(0, 0, 1, 1);
            add(camFollow);
            FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

            bgcubes = new FlxBackdrop(Paths.image('Menu New/newGrid', 'ridzak'), 0.15, 0.15, true, true);
            add(bgcubes);

            creditsInfo = CoolUtil.coolTextFile('assets/ridzak/images/credits/Links.txt');

            caps = new FlxTypedGroup<FlxSprite>();
            add(caps);

            for (i in 0...creditsInfo.length)
                {
                    var credSpr:FlxSprite;
                    credSpr = new FlxSprite().loadGraphic(Paths.image('credits/${creditsInfo[i].split('|')[0]}', 'ridzak'));
                    credSpr.scrollFactor.x = 0;
                    credSpr.scrollFactor.y = 0;
                    credSpr.screenCenter();
                    credSpr.antialiasing = true;
                    credSpr.visible = false;
                    credSpr.ID = i;
                    creditColors.insert(creditColors.length, FlxColor.fromInt(CoolUtil.dominantColor(credSpr)));
                    caps.add(credSpr);
                }

            overlayCorner = new FlxSprite(-59,0).loadGraphic(Paths.image('Menu New/Thingy', 'ridzak'));
            overlayCorner.updateHitbox();
            overlayCorner.scrollFactor.set();
            //overlayCorner.visible = true;
            overlayCorner.antialiasing = true;	
            add(overlayCorner);

            var addY:Float = -200;
            menuItems = new FlxTypedGroup<FlxText>();
            add(menuItems);
            for (i in 0...creditsInfo.length)
            {
                addY += 200;
                var verstxt:FlxText = new FlxText(-600,addY, FlxG.width, creditsInfo[i].split('|')[0], 20);
                verstxt.setFormat(Paths.font("Bubblegum.ttf"), 60, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
                //verstxt.scrollFactor.set();
                verstxt.ID = i;
                verstxt.borderSize = 2.25;
                menuItems.add(verstxt);
            }

            blackOverlay = new FlxSprite(-55,30).loadGraphic(Paths.image('Menu New/overlayBalck', 'ridzak'));
            blackOverlay.updateHitbox();
            blackOverlay.screenCenter();
            blackOverlay.scrollFactor.set();
            //overlayCorner.visible = true;
            blackOverlay.antialiasing = true;
            add(blackOverlay);
            selectUpdate(0);
            super.create();
        }
    override function update(elapsed:Float)
        {
	        if (!FlxG.sound.music.playing)
	        {
	        	FlxG.sound.playMusic(Paths.music('freakyMenu'));
	        }
            if (controls.BACK)
                {
                    FlxG.switchState(new RidZakMenu());
                }
                bgcubes.x += 0.50;
                bgcubes.y += 0.20;
                if (controls.UI_DOWN_P)
                    {
                        selectUpdate(1);
                    }
                if (controls.UI_UP_P)
                    {
                        selectUpdate(-1);
                    }
            if (controls.ACCEPT)
                {
                    FlxG.sound.play(Paths.sound('confirmMenu'));
                    #if linux
                    Sys.command('/usr/bin/xdg-open', [creditsInfo[curSelected].split('|')[1], "&"]);
                    #else
                    FlxG.openURL(creditsInfo[curSelected].split('|')[1]);
                    #end
                }

            super.update(elapsed);
        }
    function selectUpdate(change:Int)
        {
			FlxG.sound.play(Paths.sound('scrollMenu'));
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsInfo.length-1;
			if (curSelected > creditsInfo.length-1)
				curSelected = 0;

			caps.forEach(function(spr:FlxSprite)
				{
					if (spr.ID == curSelected)
						{
                            spr.visible = true;
						}
					else
						{
                            spr.visible = false;
						}
				});
			menuItems.forEach(function(spr:FlxText)
				{
					if (spr.ID == curSelected)
						{
                            spr.color = creditColors[curSelected];
							FlxTween.tween(camFollow, {y: spr.getGraphicMidpoint().y}, 0.1, {ease: FlxEase.quadInOut});
						}
					else
						{
                            spr.color = FlxColor.WHITE;
						}
				});
        }
}