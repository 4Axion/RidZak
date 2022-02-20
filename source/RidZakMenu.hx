package;

import flixel.group.FlxGroup;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;

class RidZakMenu extends MusicBeatState
{
	var camFollow:FlxObject;
	var overlayCorner:FlxSprite;
	var blackOverlay:FlxSprite;
	var bgcubes:FlxBackdrop;
	var menuItems:FlxTypedGroup<FlxSprite>;
	public static var curSelected:Int = 0;
	public static var onlyfuckonce:Bool = false;
	var debugKeys:Array<FlxKey>;
	var verstxt:FlxText;
	public static var ridzakVers:String = 'V3'; // HEY DUMB FUCK YOU SHOULD CHANGE THIS NUMBER WHEN YOU GET THE CHANCE TO UPDATE
													// sorry just a note to self :)
	var optionShit:Array<String> = ['Story', 'Freeplay', 'Credits', 'options'];
	override public function create():Void
	{
		super.create();
		FlxG.camera.zoom = 5;
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));
		FlxTween.tween(FlxG.camera, {zoom: 0.9}, 0.3, {
			ease: FlxEase.quadInOut,
			startDelay: 0.2,
			onComplete: function(twn:FlxTween)
			{
				FlxTween.tween(FlxG.camera, {zoom: 1}, 0.1, {
				});
			}
		});
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

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


		overlayCorner = new FlxSprite(-59,0).loadGraphic(Paths.image('Menu New/Thingy', 'ridzak'));
		overlayCorner.updateHitbox();
		overlayCorner.scrollFactor.set();
		//overlayCorner.visible = true;
		overlayCorner.antialiasing = true;	
		add(overlayCorner);

		var addY:Float = -200;
		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);
		for (i in 0...optionShit.length)
		{
			addY += 200;
			var optSpr:FlxSprite = new FlxSprite(-600,addY).loadGraphic(Paths.image('Menu New/${optionShit[i]}', 'ridzak'));
			optSpr.ID = i;
			optSpr.updateHitbox();
			optSpr.antialiasing = true;
			menuItems.add(optSpr);
		}

		blackOverlay = new FlxSprite(-55,30).loadGraphic(Paths.image('Menu New/overlayBalck', 'ridzak'));
		blackOverlay.updateHitbox();
		blackOverlay.screenCenter();
		blackOverlay.scrollFactor.set();
		//overlayCorner.visible = true;
		blackOverlay.antialiasing = true;
		add(blackOverlay);
		selectUpdate(0);
		onlyfuckonce = true;

		verstxt = new FlxText(0, 680, FlxG.width, 'Friday Night At The Club ${ridzakVers}', 20);
		verstxt.setFormat(Paths.font("Bubblegum.ttf"), 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		verstxt.scrollFactor.set();
		verstxt.borderSize = 1.25;
		add(verstxt);
		PlayState.freeplayACC = true;
    }
	var lockmove:Bool = false;
	override function update(elapsed:Float)
	{
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
		if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}
			/*if (!lockmove){
				spr.x = FlxG.mouse.screenX-100;
				if (FlxG.keys.justPressed.X)
					lockmove = true;
			}
			if (FlxG.keys.justPressed.C)
				trace(spr.x);*/
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
				var flashDelay:Float = 0.15;
				menuItems.forEach(function(spr:FlxSprite)
					{
						if (spr.ID == curSelected)
							{
								new FlxTimer().start(flashDelay, function(tmr:FlxTimer)
								{
									spr.loadGraphic(Paths.image('Menu New/${optionShit[spr.ID]}GlowInv', 'ridzak'));
								new FlxTimer().start(flashDelay, function(tmr:FlxTimer)
								{
									spr.loadGraphic(Paths.image('Menu New/${optionShit[spr.ID]}Glow', 'ridzak'));
								new FlxTimer().start(flashDelay, function(tmr:FlxTimer)
								{
									spr.loadGraphic(Paths.image('Menu New/${optionShit[spr.ID]}GlowInv', 'ridzak'));
								new FlxTimer().start(flashDelay, function(tmr:FlxTimer)
								{
									spr.loadGraphic(Paths.image('Menu New/${optionShit[spr.ID]}Glow', 'ridzak'));
								switch (optionShit[spr.ID])
								{
									case 'Story':
										FlxG.switchState(new Penis());
									case 'Freeplay':
										FlxG.switchState(new FreeplayState());
									case 'Credits':
										/*#if linux
										Sys.command('/usr/bin/xdg-open', ["https://gamebanana.com/mods/291356", "&"]);
										#else
										FlxG.openURL('https://gamebanana.com/mods/291356');
										#end*/
										FlxG.switchState(new Credits());
									case 'options':
										MusicBeatState.switchState(new options.OptionsState());
								}
								});
								});
								});
								});
							}
					});
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				MusicBeatState.switchState(new editors.MasterEditorMenu());
			}
			#end
		super.update(elapsed);
    }
	function selectUpdate(by:Int)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			curSelected += by;
			if (curSelected < 0)
				curSelected = optionShit.length-1;
			if (curSelected > optionShit.length-1)
				curSelected = 0;
			menuItems.forEach(function(spr:FlxSprite)
				{
					if (spr.ID == curSelected)
						{
							spr.loadGraphic(Paths.image('Menu New/${optionShit[spr.ID]}Glow', 'ridzak'));
							FlxTween.tween(camFollow, {y: spr.getGraphicMidpoint().y}, 0.1, {ease: FlxEase.quadInOut});
							//FlxTween.tween(spr, {x: x+40}, 0.4, {ease: FlxEase.quadInOut});
						}
					else
						{
							spr.loadGraphic(Paths.image('Menu New/${optionShit[spr.ID]}', 'ridzak'));
						}
				});
		}
}