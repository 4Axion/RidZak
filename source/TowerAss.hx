package;

import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
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
import flixel.FlxObject;
import openfl.filters.ShaderFilter;
import openfl.display.BlendMode;
import flixel.FlxCamera;
import WeekData;

using StringTools;
class TowerAss extends MusicBeatState
{
	var pf:String = 'poopoopeepee/';
	var bg:FlxSprite;
	var overlay:FlxSprite;
	var tower:FlxSprite;
	private var camGame:FlxCamera;
	var leScroll:Float = 2;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var bgcubes:FlxBackdrop;
	var floorItems:FlxTypedGroup<FlxSprite>;
	var logoman:FlxTypedGroup<FlxSprite>;
	var placeItems:Array<String> = ['Floordollar','Floor5','Floor4','Floor3','Floor2','Floor1','Floor0'];
	var theShiz:Array<String> = ['BLACKAss m','BLACKRidZak','BLACKZardy','Stixs','EerieBig','Faygo','RidZak'];
	//var amogus:Array<String> = ['face','face','face','stixs','eerie','cybbr','ridzak']; // ANOTHER ARRAY CUS IM DUM OKAY?!?!?!
	var isLocked:Array<Bool> = 	[false,    false,   false,      false,   true];
	var towerOffset:Float;
	public static var difficulty:String = '-hard';
	public static var curDifficulty:Int = 1;

	public static var curFloor:Int = 6;
	var selectedSomeShit:Bool = false;
	var xOffscreen:Float = 1200;
	var xOnscreen:Float = 400;
	var whoops:FlxText;
	var textDiff:FlxSprite;
	var lock:FlxSprite;
	var grpLocks:FlxTypedGroup<FlxSprite>;
	var weekCompleted:Map<String, Bool> = new Map<String, Bool>();
	override public function create():Void
	{
		weekCompleted = StoryMenuState.weekCompleted;
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		//if (curFloor != -2)
		bg = new FlxSprite().loadGraphic(Paths.image('${pf}Background','ridzak'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.scrollFactor.set(0, leScroll/placeItems.length/2);
		bg.setGraphicSize(Std.int(bg.width * 1.4));
		add(bg);
		bgcubes = new FlxBackdrop(Paths.image('mainGrid', 'ridzak'), 0.15, 0.15, true, true);
		bgcubes.alpha = 0.6;
		add(bgcubes);

		tower = new FlxSprite(-1400,0).loadGraphic(Paths.image('${pf}Tower','ridzak'));
		tower.antialiasing = ClientPrefs.globalAntialiasing;
		tower.setGraphicSize(Std.int(tower.width * 1.25));
		add(tower);

		floorItems = new FlxTypedGroup<FlxSprite>();
		add(floorItems);
		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);
		logoman = new FlxTypedGroup<FlxSprite>();
		add(logoman);
		whoops = new FlxText(0,0, 0, "Coming Soon!", 72);
		whoops.setFormat(Paths.font("Bubblegum.ttf"), 72, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		whoops.borderSize = 1.4;
		whoops.visible = false;
		whoops.scrollFactor.set();
		whoops.x += 80;
		whoops.y += 40;
		add(whoops);

		towerOffset = -150;

		overlay = new FlxSprite().loadGraphic(Paths.image('${pf}Border','ridzak'));
		overlay.antialiasing = ClientPrefs.globalAntialiasing;
		overlay.scrollFactor.set();
		add(overlay);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		var addY:Float = -1000;
		bg.y = addY/2+400;
		//tower.y = 180;
		for (i in 0...placeItems.length)
			{
				addY += 200;
				var optSpr:FlxSprite = new FlxSprite(-900,addY).loadGraphic(Paths.image('$pf${placeItems[i]}', 'ridzak'));
				optSpr.ID = i;
				optSpr.y = addY;
				optSpr.setGraphicSize(Std.int(optSpr.width * 0.8));
				optSpr.updateHitbox();
				optSpr.antialiasing = ClientPrefs.globalAntialiasing;
				floorItems.add(optSpr);

				if (weekIsLocked(i))
				{
					var lock:FlxSprite = new FlxSprite(optSpr.width + 10 + optSpr.x,optSpr.y+40);
					lock.frames = ui_tex;
					lock.animation.addByPrefix('lock', 'lock');
					lock.animation.play('lock');
					lock.ID = i;
					lock.antialiasing = ClientPrefs.globalAntialiasing;
					grpLocks.add(lock);
				}
				
				var ridzaksucks:FlxSprite;
				if (theShiz[i].startsWith('BLACK'))
					{
						ridzaksucks = new FlxSprite().loadGraphic(Paths.image('$pf${theShiz[i].split('BLACK')[1]}', 'ridzak'));
						ridzaksucks.color = FlxColor.BLACK;
					}
				else
					{
						ridzaksucks = new FlxSprite().loadGraphic(Paths.image('$pf${theShiz[i]}', 'ridzak'));
					}
				ridzaksucks.scrollFactor.set();
				ridzaksucks.antialiasing = ClientPrefs.globalAntialiasing;
				ridzaksucks.ID = i;
				ridzaksucks.x = xOffscreen;
				ridzaksucks.y -= 100;
				ridzaksucks.setGraphicSize(Std.int(ridzaksucks.width * 0.8));
				logoman.add(ridzaksucks);

				//var icon:HealthIcon = new HealthIcon(amogus[i]);
	
			}

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);
		FlxG.camera.follow(camFollowPos, null, 1);

		floorItems.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == 5)
					{
						var add:Float = 0;
						if(floorItems.length > 4) {
							add = floorItems.length * 8;
						}
						camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
					}
			}
		);
		changeItem(0);
		
		WeekData.reloadWeekFiles(true);
		
		textDiff = new FlxSprite(873, 112).loadGraphic(Paths.image('diff/normal', 'ridzak'));
		textDiff.scrollFactor.set();
		textDiff.setGraphicSize(Std.int(textDiff.width * 0.4));
		add(textDiff);
		changeDifficulty(0);

		super.create();
    }
	function weekIsLocked(weekNum:Int) {
		var leBool:Bool = true;
		switch(weekNum)
		{
			case 6: //ridz
				leBool = false;
			case 5: //cyb
				if (FlxG.save.data.weekTwodone == true)
					{
						leBool = false;
					}
			case 4: //eeri
				if (FlxG.save.data.weekThreedone == true)
					{
						leBool = false;
					}
			case 3: //stixs
				if (FlxG.save.data.weekFourdone == true)
					{
						leBool = false;
					}
		}
		return leBool;
	}
	override function update(elapsed:Float)
	{
		textDiff.visible = !weekIsLocked(curFloor);
		//logoman.visible = !weekIsLocked(curFloor);

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}
		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
		if (controls.UI_UP_P && !selectedSomeShit)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeItem(-1);
		}
		if (controls.UI_RIGHT_P)
			changeDifficulty(1);
		if (controls.UI_LEFT_P)
			changeDifficulty(-1);

		if (controls.UI_DOWN_P && !selectedSomeShit)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeItem(1);
		}

		if (FlxG.keys.justPressed.R)
			{
				MusicBeatState.switchState(new TowerAss());
			}

		bgcubes.x += 0.50;
		bgcubes.y += 0.20;
		if (controls.ACCEPT && !selectedSomeShit)
			{
				if (curFloor < 3)
				selectedSomeShit = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));
				var flashDelay:Float = 0.15;
				floorItems.forEach(function(spr:FlxSprite)
					{
						if (spr.ID == curFloor)
							{
								new FlxTimer().start(flashDelay, function(tmr:FlxTimer)
								{
									spr.loadGraphic(Paths.image('${pf}${placeItems[spr.ID]}selected', 'ridzak'));
								new FlxTimer().start(flashDelay, function(tmr:FlxTimer)
								{
									spr.loadGraphic(Paths.image('${pf}${placeItems[spr.ID]}select', 'ridzak'));
								new FlxTimer().start(flashDelay, function(tmr:FlxTimer)
								{
									spr.loadGraphic(Paths.image('${pf}${placeItems[spr.ID]}selected', 'ridzak'));
								new FlxTimer().start(flashDelay, function(tmr:FlxTimer)
								{
									spr.loadGraphic(Paths.image('${pf}${placeItems[spr.ID]}select', 'ridzak'));
								switch (placeItems[spr.ID])
								{
									case 'Floor0': // ridzak
										selectWeek(0);
									case 'Floor1': // cybbr
										selectWeek(1);
									case 'Floor2': // eerie
										selectWeek(2);
									case 'Floor3': // stixs
										selectWeek(3);
									case 'Floor4': // zardy
										cockingsoon();
									case 'Floor5': // bonus ridzak
										cockingsoon();
									case 'Floordollar': // cash deez nuts
										cockingsoon();
								}
								});
								});
								});
								});
							}
					});
			}
		floorItems.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == 1)
					{
						tower.y = spr.y+towerOffset;
					}
			});
			if (controls.BACK)
				{
					MusicBeatState.switchState(new Penis());
				}
		super.update(elapsed);
    }

	function cockingsoon()
		{
			whoops.text = 'Coming Soon!';
			FlxG.sound.play(Paths.sound('fail'), 0.7);
			whoops.visible = true;
			selectedSomeShit = false;
		}
	function isLock()
		{
			whoops.text = 'Week Locked!';
			FlxG.sound.play(Paths.sound('fail'), 0.7);
			whoops.visible = true;
			selectedSomeShit = false;
		}
	function changeItem(huh:Int = 0)
	{
		whoops.visible = false;
		curFloor += huh;

		if (curFloor >= floorItems.length)
			curFloor = 0;
		if (curFloor < 0)
			curFloor = Std.int(floorItems.length - 1);

		floorItems.forEach(function(spr:FlxSprite)
		{
			if (spr.ID == curFloor)
			{
				spr.loadGraphic(Paths.image('${pf}${placeItems[spr.ID]}select', 'ridzak'));
				var add:Float = 0;
				if(floorItems.length > 4) {
					add = floorItems.length * 8;
				}
				if (curFloor != 6)
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
			}
			else
			{
				var add:Float = 0;
				if(floorItems.length > 4) {
					add = floorItems.length * 8;
				}
				if (curFloor == 6 && spr.ID == 5)
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.loadGraphic(Paths.image('${pf}${placeItems[spr.ID]}', 'ridzak'));
			}
		});
		logoman.forEach(function(spr:FlxSprite)
		{
			if (spr.ID == curFloor)
			{
				FlxTween.tween(spr, {x: xOnscreen}, 0.2, {
					ease: FlxEase.elasticOut
				});
			}
			else
			{
				FlxTween.tween(spr, {x: xOffscreen}, 0.2, {
					ease: FlxEase.elasticOut
				});
			}
		});
	}

	function playsongs(songName:Array<String>)
		{
				var poop:String = Highscore.formatSong(songName[0].toLowerCase(), 2);
				PlayState.SONG = Song.loadFromJson(poop, songName[0].toLowerCase());
				PlayState.isStoryMode = true;
				PlayState.storyDifficulty = 2;
				PlayState.storyPlaylist = songName;
				PlayState.storyWeek = 6;
			
			LoadingState.loadAndSwitchState(new PlayState());

			FlxG.sound.music.volume = 0;
		}
	
		var movedBack:Bool = false;
		var selectedWeek:Bool = false;
		var stopspamming:Bool = false;
	
		function selectWeek(curWeek:Int)
		{
			if (!weekIsLocked(curFloor))
			{
				//FlxG.sound.play(Paths.sound('confirmMenu'));
				// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.

				PlayState.customreturn = true;
				PlayState.returnstate = function(){
					PlayState.customreturn = false;
					FlxG.switchState(new TowerAss());
				};

				var songArray:Array<String> = [];
				var leWeek:Array<Dynamic> = WeekData.weeksLoaded.get(WeekData.weeksList[curWeek]).songs;
				for (i in 0...leWeek.length) {
					songArray.push(leWeek[i][0]);
					trace('PUSHED '+leWeek[i][0]);
				}
	
				// Nevermind that's stupid lmao
				PlayState.storyPlaylist = songArray;
				PlayState.isStoryMode = true;
				selectedWeek = true;

				var diffic = '';
				if (curDifficulty != 1)
					diffic = '-'+getDifficultyFromNum(curDifficulty);
				trace('difficulty is '+diffic);

				difficulty = diffic;
			
				PlayState.storyDifficulty = curDifficulty;
	
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
				PlayState.campaignScore = 0;
				PlayState.campaignMisses = 0;
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState(), true);
					FreeplayState.destroyFreeplayVocals();
				});
			}
			else
				{
					isLock();
				}
		}

		function changeDifficulty(change:Int = 0):Void
		{
			curDifficulty += change;
	
			if (curDifficulty < 0)
				curDifficulty = 2;
			if (curDifficulty > 2)
				curDifficulty = 0;
	
			textDiff.offset.x = 0;
	
			switch (curDifficulty)
			{
				case 1:
						remove(textDiff);
						textDiff = new FlxSprite(880, 100).loadGraphic(Paths.image('diff/normal', 'ridzak'));
						textDiff.scrollFactor.set();
						textDiff.setGraphicSize(Std.int(textDiff.width * 0.4));
						add(textDiff);
					case 2:
							remove(textDiff);
							textDiff = new FlxSprite(880, 100).loadGraphic(Paths.image('diff/hard', 'ridzak'));
							textDiff.scrollFactor.set();
							textDiff.setGraphicSize(Std.int(textDiff.width * 0.4));
							add(textDiff);
						case 0:
								remove(textDiff);
								textDiff = new FlxSprite(880, 100).loadGraphic(Paths.image('diff/easy', 'ridzak'));
								textDiff.scrollFactor.set();
								textDiff.setGraphicSize(Std.int(textDiff.width * 0.4));
								add(textDiff);
			}
	
			textDiff.alpha = 0;
	
			var mainy:Float = 470;
			// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
			textDiff.y = mainy - 15;
	
			FlxTween.tween(textDiff, {y: mainy + 15, alpha: 1}, 0.07);
		}
		function getDifficultyFromNum(num:Int)
			{
				var difficultiesArray:Array<String> = ['easy','normal','hard']; // I know there's a system for this but like fuck that :troll:
	
				return difficultiesArray[num];
			}
}