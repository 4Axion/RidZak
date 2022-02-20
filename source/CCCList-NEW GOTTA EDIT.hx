package;

import flixel.group.FlxGroup;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;
import flixel.util.FlxTimer;
import lime.app.Application;
import flixel.FlxCamera;
import editors.MasterEditorMenu;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import Character;

class CCCList extends MusicBeatState
{
	var camFollow:FlxObject;
	var overlayCorner:FlxSprite;
	var overlayCorner2:FlxSprite;
	var blackOverlay:FlxSprite;
	var bgcubes:FlxBackdrop;
	var menuItems:FlxTypedGroup<FlxSprite>;
	var peopes:FlxTypedGroup<FlxSprite>;
	public static var curSelected:Int = 0;
	public static var onlyfuckonce:Bool = false;
	var debugKeys:Array<FlxKey>;
	var whoops:FlxText;
	var peepDefX:Float;
	var peepOfs:Float;
	var colorTween:FlxTween;
	var colorTweenb1:FlxTween;
	var colorTweenb2:FlxTween;
	var bg:FlxSprite;
	public static var abBBB:Bool = false;
	var ridzak:Character = null;
	var ridzakm:Character = null;
	var ridzakc:Character = null;
	var isRidzak:Int = 0;
	
	var colorShit:Array<FlxColor> = [0xFF28aebf,0xFFffffff,0xFF9f32fd,0xFF0084ff,0xFF586382,0xFF1bcf39,0xFFfbff00,0xFF0400ff];
	var optionShit:Array<String> = ['Anders', 'Flexy', 'SynTech', 'Cj', 'Cheeky', 'Richard', 'DnF', 'Rian'];
	override public function create():Void
	{
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

		bg = new FlxSprite(0).loadGraphic(Paths.image('CCC MENU/newBack', 'ridzak'));
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

		peopes = new FlxTypedGroup<FlxSprite>();
		add(peopes);
		var np:Array<String> = CoolUtil.coolTextFile(Paths.txt('DELETE THE CCC'));
		for (i in 0...optionShit.length)
			{
				peepDefX = Std.parseFloat(np[9]);
				peepOfs = Std.parseFloat(np[11]);
				var peopleScreen:FlxSprite = new FlxSprite(peepDefX,Std.parseFloat(np[15])).loadGraphic(Paths.image('CCC MENU/${optionShit[i]}', 'ridzak'));
				peopleScreen.setGraphicSize(Std.int(bg.width * Std.parseFloat(np[7])));
				peopleScreen.updateHitbox();
				peopleScreen.ID = i;
				peopleScreen.scrollFactor.x = 0;
				peopleScreen.scrollFactor.y = 0;
				peopleScreen.antialiasing = true;
				peopes.add(peopleScreen);
			}


		overlayCorner = new FlxSprite(Std.parseFloat(np[1]),Std.parseFloat(np[2])).loadGraphic(Paths.image('CCC MENU/Bar1', 'ridzak'));
		overlayCorner.setGraphicSize(Std.int(overlayCorner.width * Std.parseFloat(np[17])));
		overlayCorner.updateHitbox();
		overlayCorner.scrollFactor.set();
		//overlayCorner.visible = true;
		overlayCorner.antialiasing = true;	
		add(overlayCorner);

		overlayCorner2 = new FlxSprite(Std.parseFloat(np[4]),Std.parseFloat(np[5])).loadGraphic(Paths.image('CCC MENU/Bar2', 'ridzak'));
		overlayCorner2.setGraphicSize(Std.int(overlayCorner2.width * Std.parseFloat(np[18])));
		overlayCorner2.updateHitbox();
		overlayCorner2.scrollFactor.set();
		overlayCorner2.antialiasing = true;	
		add(overlayCorner2);

		var addY:Float = -200;
		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);
		for (i in 0...optionShit.length)
		{
			addY += 200;
			var optSpr:FlxSprite = new FlxSprite(-600,addY).loadGraphic(Paths.image('CCC MENU/btns/${optionShit[i]}Logo', 'ridzak'));
			optSpr.ID = i;
			optSpr.setGraphicSize(Std.int(bg.width * Std.parseFloat(np[13])));
			optSpr.updateHitbox();
			//if (FlxG.save.data.andersRidzakcrossUnlock == false && optionShit[i] == 'Anders')
			//	optSpr.color = FlxColor.BLACK;
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
		if (!onlyfuckonce)
		selectUpdate(1);
		onlyfuckonce = true;

		whoops = new FlxText(0,0, 0, "Temp Message", 72);
		whoops.setFormat(Paths.font("Bubblegum.ttf"), 72, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		whoops.borderSize = 1.4;
		whoops.visible = false;
		whoops.scrollFactor.set();
		whoops.x += 80;
		whoops.y += 40;
		add(whoops);
		selectUpdate(0);
		addRidzak();
		//add(ridzak);
		//add(ridzakm);
		super.create();
    }
	var lockmove:Bool = false;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
		if (controls.BACK)
			{
				if(colorTween != null) {
					colorTween.cancel();
				}
				if(colorTweenb1 != null) {
					colorTweenb1.cancel();
				}
				if(colorTweenb2 != null) {
					colorTweenb2.cancel();
				}
				FlxG.switchState(new Penis());
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
		if (FlxG.keys.justPressed.O)
			{
				MusicBeatState.switchState(new CCCList());
			}
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
				if(colorTween != null) {
					colorTween.cancel();
				}
				if(colorTweenb1 != null) {
					colorTweenb1.cancel();
				}
				if(colorTweenb2 != null) {
					colorTweenb2.cancel();
				}
				if (optionShit[curSelected] == 'DnF')
					FlxG.sound.play(Paths.sound('fard'));
				else
					FlxG.sound.play(Paths.sound('confirmMenu'));

				var flashDelay:Float = 0.15;
				menuItems.forEach(function(spr:FlxSprite)
					{
						if (spr.ID == curSelected)
							{
								new FlxTimer().start(flashDelay, function(tmr:FlxTimer)
								{
									spr.loadGraphic(Paths.image('CCC MENU/btns/${optionShit[spr.ID]}', 'ridzak'));
								new FlxTimer().start(flashDelay, function(tmr:FlxTimer)
								{
									spr.loadGraphic(Paths.image('CCC MENU/btns/${optionShit[spr.ID]}Out', 'ridzak'));
								new FlxTimer().start(flashDelay, function(tmr:FlxTimer)
								{
									spr.loadGraphic(Paths.image('CCC MENU/btns/${optionShit[spr.ID]}', 'ridzak'));
								new FlxTimer().start(flashDelay, function(tmr:FlxTimer)
								{
									spr.loadGraphic(Paths.image('CCC MENU/btns/${optionShit[spr.ID]}Out', 'ridzak'));
								switch (optionShit[spr.ID])
								{
									case 'Anders':
										/*if (FlxG.save.data.andersRidzakcrossUnlock == false)
											cockingsoon();
										else*/
											playsong('Hallucinogenic');
									case 'Flexy':
										playsong('Rebound');
									case 'SynTech':
										playsong('Mainframe');
									case 'Cj':
										playsong('Neoteric');
									case 'Cheeky':
										playsong('Salami');
									case 'Richard':
										playsong('Billionaire-Brawl');
									case 'DnF':
										playsong('Goodfellas');
									case 'Rian':
										playsong('Frenzy');
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
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
			
		if(controls.RESET)
			{
				if (FlxG.save.data.andersRidzakcrossUnlock == true && optionShit[curSelected] == 'Anders')
					{
						openSubState(new ResetAndersCode());
						FlxG.sound.play(Paths.sound('scrollMenu'));
					}
			}

		if (abBBB)
			{
				ridzakm.color = FlxColor.BLACK;
				ridzakc.color = FlxColor.BLACK;
				FlxG.save.data.classicUnlocked = false;
				FlxG.save.data.minusUnlocked = false;
				abBBB = false;
			}
			if(ridzak != null && ridzak.animation.curAnim.finished) {
				ridzak.dance();
			}
			if(ridzakm != null && ridzakm.animation.curAnim.finished) {
				ridzakm.dance();
			}
		if (controls.UI_LEFT_P)
			{
				changeRidZak(-1);
			}
			if (controls.UI_RIGHT_P)
				{
					changeRidZak(1);
				}
		super.update(elapsed);
    }
	
	function playsong(songName:String)
		{
			if (FlxG.save.data.currentRidzak == 'minus' && !FlxG.save.data.minusUnlocked == true)
				return noballsNoMinus(); // fuck you for even thinking about it!

			var poop:String = songName.toLowerCase()+'-hard';
			PlayState.SONG = Song.loadFromJson(poop, songName.toLowerCase());
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = 2;

			PlayState.storyWeek = 6;

			PlayState.customreturn = true;
			PlayState.returnstate = function(){
				PlayState.customreturn = false;
				FlxG.switchState(new CCCList());
			};

			if (songName == 'Frenzy') // multiple songs without it screwing up shit :)))))
				{
					extraSong('Rocker');
				}
			
			LoadingState.loadAndSwitchState(new PlayState());

			FlxG.sound.music.volume = 0;
		}

		function extraSong(songPp:String)
			{
				PlayState.returnstate = function(){
					var poop:String = songPp.toLowerCase()+'-hard';
					PlayState.SONG = Song.loadFromJson(poop, songPp.toLowerCase());
					PlayState.isStoryMode = false;
					PlayState.storyDifficulty = 2;
		
					PlayState.storyWeek = 6;
		
					PlayState.customreturn = true;
					PlayState.returnstate = function(){
						PlayState.customreturn = false;
						FlxG.switchState(new CCCList());
					};
			
					LoadingState.loadAndSwitchState(new PlayState());
				};
			}
		function cockingsoon()
			{
				FlxG.sound.play(Paths.sound('fail'), 0.7);
				whoops.text = "Unlock this in the code room!";
				whoops.visible = true;
				new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						whoops.visible = false;
					});
			}
		function noballsNoMinus()
			{
				FlxG.sound.play(Paths.sound('fail'), 0.7);
				whoops.text = 'Character Not Unlocked!';
				whoops.visible = true;
				new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						whoops.visible = false;
					});
			}
	function selectUpdate(by:Int)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			curSelected += by;
			if (curSelected < 0)
				curSelected = optionShit.length-1;
			if (curSelected > optionShit.length-1)
				curSelected = 0;

			if(colorTween != null) {
				colorTween.cancel();
			}
			if(colorTweenb1 != null) {
				colorTweenb1.cancel();
			}
			if(colorTweenb2 != null) {
				colorTweenb2.cancel();
			}
			colorTween = FlxTween.color(bg, 1, bg.color, colorShit[curSelected], {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
			colorTweenb1 = FlxTween.color(overlayCorner, 1, bg.color, colorShit[curSelected], {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
			colorTweenb2 = FlxTween.color(overlayCorner2, 1, bg.color, colorShit[curSelected], {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
			peopes.forEach(function(spr:FlxSprite)
				{
					if (spr.ID == curSelected)
						{
							FlxTween.tween(spr, {x: peepDefX}, 0.4, {ease: FlxEase.quadInOut});
						}
					else
						{
							FlxTween.tween(spr, {x: peepDefX+peepOfs}, 0.4, {ease: FlxEase.quadInOut});
						}
				});
			menuItems.forEach(function(spr:FlxSprite)
				{
					if (spr.ID == curSelected)
						{
							spr.loadGraphic(Paths.image('CCC MENU/btns/${optionShit[spr.ID]}Out', 'ridzak'));
							FlxTween.tween(camFollow, {y: spr.getGraphicMidpoint().y}, 0.1, {ease: FlxEase.quadInOut});
							//FlxTween.tween(spr, {x: x+40}, 0.4, {ease: FlxEase.quadInOut});
						}
					else
						{
							spr.loadGraphic(Paths.image('CCC MENU/btns/${optionShit[spr.ID]}Logo', 'ridzak'));
						}
				});
		}

		function addRidzak()
			{
				var wasVisible:Bool = false;
				var ridzakx:Float = 980;
				var ridzaky:Float = 380;
				var ridzakScale:Float = 0.4;
				if(ridzak != null) {
					wasVisible = ridzak.visible;
					ridzak.kill();
					remove(ridzak);
					ridzak.destroy();
				}
		
				ridzak = new Character(ridzakx, ridzaky, 'ridzak-playable', true);
				ridzak.setGraphicSize(Std.int(ridzak.width * ridzakScale));
				ridzak.updateHitbox();
				ridzak.scrollFactor.x = 0;
				ridzak.scrollFactor.y = 0;
				ridzak.dance();
				add(ridzak);
				//insert(1, ridzak);
		
				if(ridzakm != null) {
					ridzakm.kill();
					remove(ridzakm);
					ridzakm.destroy();
				}
		
				ridzakm = new Character(ridzakx, ridzaky, 'ridzak-pminus', true);
				ridzakm.setGraphicSize(Std.int(ridzakm.width * ridzakScale+0.3));
				ridzakm.updateHitbox();
				ridzakm.scrollFactor.x = 0;
				ridzakm.scrollFactor.y = 0;
				if (!FlxG.save.data.minusUnlocked == true)
					ridzakm.color = FlxColor.BLACK;
				ridzakm.dance();
				add(ridzakm);
				//insert(2, ridzakm);
				if(ridzakm != null) {
					ridzakm.kill();
					remove(ridzakm);
					ridzakm.destroy();
				}
		
				ridzakc = new Character(ridzakx, ridzaky, 'ridzak-pclassic', true);
				ridzakc.setGraphicSize(Std.int(ridzakc.width * ridzakScale+0.3));
				ridzakc.updateHitbox();
				ridzakc.scrollFactor.x = 0;
				ridzakc.scrollFactor.y = 0;
				if (!FlxG.save.data.classicUnlocked == true)
					ridzakc.color = FlxColor.BLACK;
				ridzakc.dance();
				add(ridzakc);

				if (FlxG.save.data.currentRidzak == null)
					FlxG.save.data.currentRidzak = 'ridzak';
		
				if (FlxG.save.data.currentRidzak == 'ridzak')
					{
						isRidzak = 0;
						ridzak.visible = true;
						ridzakm.visible = false;
						ridzakc.visible = false;
					}
				else if (FlxG.save.data.currentRidzak == 'minus')
					{
						isRidzak = 1;
						ridzak.visible = false;
						ridzakm.visible = true;
						ridzakc.visible = false;
					}
				else if (FlxG.save.data.currentRidzak == 'classic')
					{
						isRidzak = 2;
						ridzak.visible = false;
						ridzakm.visible = false;
						ridzakc.visible = true;
					}
			}
		function changeRidZak(changeThing:Int)
			{
				isRidzak += changeThing;
				ridzak.y -= 15;
				ridzak.alpha = 0;
				ridzakm.y -= 15;
				ridzakm.alpha = 0;
				ridzakc.y -= 15;
				ridzakc.alpha = 0;
				switch (isRidzak)
				{
					case 0:
						FlxG.save.data.currentRidzak = 'ridzak';
						ridzak.visible = true;
						ridzakm.visible = false;
						ridzakc.visible = false;
					case 1:
						FlxG.save.data.currentRidzak = 'minus';
						ridzak.visible = false;
						ridzakm.visible = true;
						ridzakc.visible = false;
					case 2:
						FlxG.save.data.currentRidzak = 'classic';
						ridzak.visible = false;
						ridzakm.visible = false;
						ridzakc.visible = true;
				}
				FlxTween.tween(ridzak, {y: ridzak.y + 15, alpha: 1}, 0.07);
				FlxTween.tween(ridzakm, {y: ridzakm.y + 15, alpha: 1}, 0.07);
				FlxTween.tween(ridzakc, {y: ridzakc.y + 15, alpha: 1}, 0.07);
			}
}