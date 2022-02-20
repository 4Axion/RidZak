package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;

import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.addons.display.FlxBackdrop;
import lime.net.curl.CURLCode;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class Penis extends MusicBeatState
{
	var scoreText:FlxText;

	var weekData:Array<Dynamic> = [ // THE AMOUNT OF ITEMS IS THIS FUCKING SHIT
		['Odyssey','Challenger', 'Ouch', 'Ego', 'Vibe'],
		['Orbit', 'Genesis', 'Golden'],
		['Frenzy', 'Vast'],
		['coded your mom']
	];
	var curDifficulty:Int = 1;

	public static var weekUnlocked:Array<Bool> = [true, true, true, true];

	var weekCharacters:Array<String> = [
		'FNAF',
		'CCC',
		'Skywood',
		'CoderOOM'
	];

	var txtWeekTitle:FlxText;

	public static var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItemButAwesome>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var bgcubes:FlxBackdrop;


	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		if (FlxG.save.data.weekUnlocked != null)
			weekUnlocked = FlxG.save.data.weekUnlocked;
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		scoreText = new FlxText(10, 10, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("VCR OSD Mono", 32);

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		var yellowBG:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 400, 0xFFF9CF51);

		var realbg:FlxSprite = new FlxBackdrop(Paths.image('StoryBlue', 'ridzak'), 0.3, 0.3, true, true);
		var linesbg:FlxSprite = new FlxBackdrop(Paths.image('Blue2', 'ridzak'), 0.3, 0.3, true, true);
		bgcubes = new FlxBackdrop(Paths.image('BlueGrid', 'ridzak'), 0.3, 0.3, true, true);

		realbg.scale.set(0.68513585508,0.60833333333);
		realbg.updateHitbox();
		realbg.y += 56;
		realbg.screenCenter();
		linesbg.scale.set(0.68513585508,0.60833333333);
		linesbg.updateHitbox();
		linesbg.screenCenter();
		linesbg.y += 56;

		add(realbg);
		add(linesbg);
		add(bgcubes);
		
		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		//add(blackBarThingie);

		var blackBarBottom:FlxSprite = new FlxSprite(0, 456).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		//add(blackBarBottom);
		
		grpWeekText = new FlxTypedGroup<MenuItemButAwesome>();
		add(grpWeekText);

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();
		add(grpWeekCharacters);
		var ridzakWeek:FlxSprite = new FlxSprite(FlxG.width / 4, FlxG.height / 4).loadGraphic(Paths.image('ridzak', 'ridzak'));
		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		
		trace("Line 70");
		var weekScales:Array<Float> = [0.3,0.3,0.5,0.5];
		var stupidassoffsets:Array<Int> = [2050,1100,450,450]; // IM BAD AT PROGRAMMING OKAY?!?!
		for (i in 0...4) {
			var weekThing:MenuItemButAwesome = new MenuItemButAwesome(-200, -200, i, weekCharacters[i], weekScales[i], stupidassoffsets[i]);
			/*if (i == 0) {
				weekThing.visible = false;
			}*/
			//weekThing.y += ((weekThing.height + 20) * i);
			weekThing.targetY = i;
			weekThing.ID = i;
			weekThing.screenCenter();
			grpWeekText.add(weekThing);
			weekThing.scale.set(0.5*weekScales[i], 0.5*weekScales[i]);
			//weekThing.x = -300 + i * 200;
			weekThing.visible = true;
			weekThing.antialiasing = true;
			weekThing.defSize = weekThing.width;
			trace(weekThing);
			if (!weekUnlocked[i])
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x).loadGraphic(Paths.image('lock', 'ridzak'));
				lock.ID = i;
				lock.antialiasing = true;
				lock.scale.set(0.5, 0.5);
				grpLocks.add(lock);
			}
		}
		/*for (i in 0...weekData.length)
		{
			var weekThing:MenuItemButAwesome = new MenuItemButAwesome(-200, -200, i, weekCharacters[i]);
			weekThing.y += ((weekThing.height + 20) * i);
			weekThing.targetY = i;
			grpWeekText.add(weekThing);
			weekThing.scale.set(0.5, 0.5);
			weekThing.screenCenter(X);
			//weekThing.x = -300 + i * 200;
			weekThing.antialiasing = true;
			// weekThing.updateHitbox();

			// Needs an offset thingie
			if (!weekUnlocked[i])
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				lock.antialiasing = true;
				//grpLocks.add(lock);
			}
		}*/

		trace("Line 96");

		/*grpWeekCharacters.add(new MenuCharacter(0, 100, 0.5, false));
		grpWeekCharacters.add(new MenuCharacter(450, 25, 0.9, true));
		grpWeekCharacters.add(new MenuCharacter(850, 100, 0.5, true));*/

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		trace("Line 124");
		sprDifficulty = new FlxSprite(0, 550);
		sprDifficulty.screenCenter(X);
		sprDifficulty.frames = Paths.getSparrowAtlas('dif');
		sprDifficulty.animation.addByIndices('easy', 'def', [0], '', 0, false);
		sprDifficulty.animation.addByIndices('normal', 'def', [1], '', 0, false);
		sprDifficulty.animation.addByIndices('hard', 'def', [2], '', 0, false);
		sprDifficulty.animation.play('easy');

		changeDifficulty();

		leftArrow = new FlxSprite(FlxG.width / 2 - 500, sprDifficulty.y + 40);
		leftArrow.screenCenter(Y);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		difficultySelectors.add(leftArrow);

		//difficultySelectors.add(sprDifficulty);

		rightArrow = new FlxSprite(FlxG.width / 2 + 500, sprDifficulty.y + 40);
		rightArrow.screenCenter(Y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		difficultySelectors.add(rightArrow);

		trace("Line 150");

		//add(yellowBG);
		//add(grpWeekCharacters);

		txtTracklist = new FlxText(FlxG.width * 0.05, yellowBG.x + yellowBG.height + 100, 0, "Tracks", 32);
		txtTracklist.alignment = CENTER;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFFe55777;
		//add(txtTracklist);
		// add(rankText);
		//add(scoreText);
		//add(txtWeekTitle);

		
		updateText();

		trace("Line 165");
		changeWeek();
		PlayState.freeplayACC = true;
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

		scoreText.text = "WEEK SCORE:" + lerpScore;

		bgcubes.x -= 0.50;
		bgcubes.y -= 0.20;

		// FlxG.watch.addQuick('font', scoreText.font);

		difficultySelectors.visible = weekUnlocked[curWeek];

		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
			lock.x  = grpWeekText.members[lock.ID].x;
		});

		/*for (i in grpWeekText) {
			if (grpWeekText.members.indexOf(i) < curWeek) {//&& i.alpha == 1) {
				FlxTween.tween(i, {alpha: 0}, 0.05);
			}
			if (i.y > 456 && i.alpha == 0) {
				FlxTween.tween(i, {alpha: 1}, 0.05);
			}
		}*/
		if (!movedBack)
		{
			if (!selectedWeek)
			{
				if (controls.UI_RIGHT_P)
				{
					changeWeek(1);
				}

				if (controls.UI_LEFT_P)
				{
					changeWeek(-1);
				}

				if (controls.UI_RIGHT)
					rightArrow.animation.play('press')
				else
					rightArrow.animation.play('idle');

				if (controls.UI_LEFT)
					leftArrow.animation.play('press');
				else
					leftArrow.animation.play('idle');

				if (controls.UI_UP_P)
					changeDifficulty(1);
				if (controls.UI_DOWN_P)
					changeDifficulty(-1);
			}

			if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			FlxG.switchState(new RidZakMenu());
		}

		/*grpWeekText.forEach(function(spr:MenuItemButAwesome)
			{
				spr.setGraphicSize(Std.int(FlxMath.lerp(150, spr.width, CoolUtil.boundTo(1 - (elapsed * 30), 0, 1))));
				spr.updateHitbox();
			});*/
		super.update(elapsed);
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (weekUnlocked[curWeek])
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

				grpWeekText.members[curWeek].startFlashing();
				stopspamming = true;
			}
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = "";

			switch (curDifficulty)
			{
				case 0:
					diffic = '-easy';
				case 2:
					diffic = '-hard';
			}

			new FlxTimer().start(1, function(tmr:FlxTimer)
			{ // LOADING SHIT
				switch (curWeek)
				{
					case 0:
						MusicBeatState.switchState(new TowerAss());
					case 1:
						MusicBeatState.switchState(new CCCList());
					case 2:
						//MusicBeatState.switchState(new SkywoodList());
						playsongs(['Vast','Scarlet']);
					case 3:
						MusicBeatState.switchState(new CodeShit());
				}
			});
			FlxTween.tween(FlxG.camera, {zoom: 0.9}, 1, {
				ease: FlxEase.quadInOut,
				onComplete: function(twn:FlxTween)
				{
					FlxTween.tween(FlxG.camera, {zoom: 10}, 0.5, {
						ease: FlxEase.quadInOut
					});
				}
			});
		}
	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;

		sprDifficulty.offset.x = 0;

		switch (curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('easy');
			case 1:
				sprDifficulty.animation.play('normal');
			case 2:
				sprDifficulty.animation.play('hard');
		}
		sprDifficulty.screenCenter(X);
		//sprDifficulty.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		//sprDifficulty.y = leftArrow.y - 15;

		//FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= weekData.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = weekData.length - 1;

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && weekUnlocked[curWeek]) {
				item.alpha = 1;
			} else {
				item.alpha = 0.2;
			}
			if (item.targetY == Std.int(0)) {
				item.big = true;
			} else {
				item.big = false;
			}
			bullShit++;
		}

		FlxG.sound.play(Paths.sound('scrollMenu'));

		updateText();
	}

	function updateText()
	{
		/*grpWeekCharacters.members[0].setCharacter(weekCharacters[curWeek][0]);
		grpWeekCharacters.members[1].setCharacter(weekCharacters[curWeek][1]);
		grpWeekCharacters.members[2].setCharacter(weekCharacters[curWeek][2]);*/

		txtTracklist.text = "Tracks\n";
		var stringThing:Array<String> = weekData[curWeek];

		for (i in stringThing)
		{
			txtTracklist.text += "\n" + i;
		}

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		txtTracklist.x -= FlxG.width * 0.35;
	}

	var lastBeatHit:Int = -1;
	override function beatHit() {
		/*grpWeekText.forEach(function(spr:FlxSprite)
		{
			spr.setGraphicSize(Std.int(spr.width + 30));
			spr.updateHitbox();
		});*/

		lastBeatHit = curBeat;
		super.beatHit();
	}
	function playsongs(songName:Array<String>)
		{
				var poop:String = songName[0].toLowerCase()+'';
				PlayState.SONG = Song.loadFromJson(poop, songName[0].toLowerCase());
				PlayState.isStoryMode = true;
				PlayState.storyDifficulty = 1;
				PlayState.storyPlaylist = songName;
				PlayState.storyWeek = 6;

				PlayState.customreturn = true;
				PlayState.returnstate = function(){
					PlayState.customreturn = false;
					FlxG.switchState(new Penis());
				};
			
			LoadingState.loadAndSwitchState(new PlayState());

			FlxG.sound.music.volume = 0;
		}
}
