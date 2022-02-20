package;

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
import flixel.group.FlxGroup.FlxTypedGroup;

class CodeShit extends MusicBeatState
{
	var doors:FlxSprite;
	//                 0,1 (1 is interactable)
	// animation , x , y , btnType , scale , function
	var daBtnThing:Array<String> = CoolUtil.coolTextFile(Paths.txt('buttons'));
	var thenum:Array<String> = [''];
	var btns:FlxTypedGroup<Button>;
	var codeText:FlxText;
	var lastCheckamogus:Float = 0;
	var maxCharacters = 7;
	
	override public function create():Void
	{
		FlxG.mouse.visible = true;
		btns = new FlxTypedGroup<Button>();
		add(btns);

		for (i in daBtnThing)
			{
				var tf:Array<String> = i.split(',');

				switch (tf[0])
				{
					case 'text':
						codeText = new FlxText(Std.parseFloat(tf[1]),Std.parseFloat(tf[2]), Std.int(FlxG.width * 0.6), "", 32);
						codeText.font = 'Pixel Arial 11 Bold';
						codeText.setFormat(null, 32, 0xFF22ff09, RIGHT);
					case 'door':
						doors = new FlxSprite(Std.parseFloat(tf[1]),Std.parseFloat(tf[2]));
						doors.frames = Paths.getSparrowAtlas('secret/doors', 'ridzak');
						doors.antialiasing = ClientPrefs.globalAntialiasing;
						doors.animation.addByPrefix('open', 'Doors', 24, false);
						doors.updateHitbox();

						doors.setGraphicSize(Std.int(doors.width * Std.parseFloat(tf[3])));
						doors.updateHitbox();
					default:
						var buttonshitter:Button = new Button(Std.parseFloat(tf[1]),Std.parseFloat(tf[2]));
						buttonshitter.frames = Paths.getSparrowAtlas('secret/CodeMachine', 'ridzak');
						buttonshitter.antialiasing = ClientPrefs.globalAntialiasing;
						buttonshitter.animation.addByPrefix('press', tf[0], 24, false);
						buttonshitter.animation.play('press');
						buttonshitter.setGraphicSize(Std.int(buttonshitter.width * Std.parseFloat(tf[4])));
						buttonshitter.updateHitbox();
						if (Std.parseInt(tf[3]) == 1)
						buttonshitter.interactable = true;
						else
						buttonshitter.interactable = false;
						buttonshitter.buttonfunction = tf[5];
						btns.add(buttonshitter);
				}
			}

			add(codeText);
			add(doors);

			new FlxTimer().start(0.8, function(tmr:FlxTimer)
				{
					FlxG.sound.play(Paths.sound('doorsOpen'), 0.7);
					doors.animation.play('open');
					FlxG.sound.playMusic(Paths.music('doorsMus'), 0.0);
					FlxG.sound.music.fadeIn(0.6, 0, 0.7);
				});

		super.create();
    }
	override function update(elapsed:Float)
	{
		lastCheckamogus += elapsed;
		if (lastCheckamogus >= 1 / 30)
			{
				lastCheckamogus = elapsed;
				var theout:String = '';
				for (i in thenum)
					{
						theout = theout+i;
					}
				codeText.text = theout;
			}

			if (controls.BACK)
				{
					FlxG.mouse.visible = false;
					FlxG.sound.music.stop();
					FlxG.sound.playMusic(Paths.music('freakyMenuINTRO'), 1);
					MusicBeatState.switchState(new RidZakMenu());
				}

				if (FlxG.keys.justPressed.R)
					{
						MusicBeatState.switchState(new CodeShit());
					}

			btns.forEach(function(spr:Button)
				{
					if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(spr))
						{
							if (spr.interactable)
								{
									spr.animation.play('press');
									doButton(spr.buttonfunction);
								}
						}
				});
			super.update(elapsed);
    }

	function doButton(thefucksIgive:String)
		{
			var soundForNum:String = 'Click';
			switch (thefucksIgive)
			{
				case '0':
					FlxG.sound.play(Paths.sound(soundForNum), 0.65);
					if (thenum.length < maxCharacters)
						thenum.insert(thenum.length,thefucksIgive);
				case '1':
					FlxG.sound.play(Paths.sound(soundForNum), 0.65);
					if (thenum.length < maxCharacters)
						thenum.insert(thenum.length,thefucksIgive);
				case '2':
					FlxG.sound.play(Paths.sound(soundForNum), 0.65);
					if (thenum.length < maxCharacters)
						thenum.insert(thenum.length,thefucksIgive);
				case '3':
					FlxG.sound.play(Paths.sound(soundForNum), 0.65);
					if (thenum.length < maxCharacters)
						thenum.insert(thenum.length,thefucksIgive);
				case '4':
					FlxG.sound.play(Paths.sound(soundForNum), 0.65);
					if (thenum.length < maxCharacters)
						thenum.insert(thenum.length,thefucksIgive);
				case '5':
					FlxG.sound.play(Paths.sound(soundForNum), 0.65);
					if (thenum.length < maxCharacters)
						thenum.insert(thenum.length,thefucksIgive);
				case '6':
					FlxG.sound.play(Paths.sound(soundForNum), 0.65);
					if (thenum.length < maxCharacters)
						thenum.insert(thenum.length,thefucksIgive);
				case '7':
					FlxG.sound.play(Paths.sound(soundForNum), 0.65);
					if (thenum.length < maxCharacters)
						thenum.insert(thenum.length,thefucksIgive);
				case '8':
					FlxG.sound.play(Paths.sound(soundForNum), 0.65);
					if (thenum.length < maxCharacters)
						thenum.insert(thenum.length,thefucksIgive);
				case '9':
					FlxG.sound.play(Paths.sound(soundForNum), 0.65);
					if (thenum.length < maxCharacters)
						thenum.insert(thenum.length,thefucksIgive);
				case 'backspace':
					FlxG.sound.play(Paths.sound('backspace'), 0.65);
					if (thenum.length != 0)
						thenum.remove(thenum[thenum.length-1]);
				case 'enter':
					FlxG.sound.play(Paths.sound(soundForNum), 0.65);
					var didSomething:Bool = false;
					for (i in Codes.codes)
						{
							if (codeText.text == i.split(',')[0])
								{
									switch (i.split(',')[1])
									{
										case 'RidzakTheRapperVideo':
											FlxG.mouse.visible = false;
											FlxG.sound.music.volume = 0;
											PlayMedia.di = ['video','thevid','coderoom'];
											LoadingState.loadAndSwitchState(new PlayMedia());
										case 'Ridchart':
											FlxG.mouse.visible = false;
											FlxG.sound.music.volume = 0;
											PlayMedia.di = ['image&audio','richart_bb','coderoom'];
											LoadingState.loadAndSwitchState(new PlayMedia());
										case 'ArcadeRoom':
											FlxG.mouse.visible = false;
											FlxG.sound.music.volume = 0;
											LoadingState.loadAndSwitchState(new arcade.PixelState());
										case 'UnlockAlpha':
											FlxG.save.data.alphaUnlocked = true;
											PixelMenu.info = ['Alpha RidZak Unlocked!','Code Room','Crazy Collab Crossover'];
											LoadingState.loadAndSwitchState(new PixelMenu());
										default:
											playsong(i.split(',')[1]);
									}
									didSomething = true;
								}
						}
					if (!didSomething)
						FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
			}
			for (i in 0...thenum.length) // doing this just so it loops the amount of times we need to check for, cope :)
				{
					if (thenum.length > maxCharacters-1) // LIMIT THE FUCKING THING FROM HAVING TOO MANY NUMBERS
						{
							thenum.remove(thenum[thenum.length]);
						}
				}
		}
	function playsong(songName:String)
		{
			var poop:String = songName.toLowerCase()+'-hard';
			PlayState.SONG = Song.loadFromJson(poop, songName.toLowerCase());
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = 2;

			if (songName == 'Hallucinogenic' || songName == 'hallucinogenic')
				FlxG.save.data.andersRidzakcrossUnlock = true;

			PlayState.storyWeek = 6;
			PlayState.customreturn = true;
			PlayState.returnstate = function(){
				PlayState.customreturn = false;
				FlxG.switchState(new CodeShit());
			};
			
			if (songName != 'Egoistic')
				LoadingState.loadAndSwitchState(new PlayState());
			else
				LoadingState.loadAndSwitchState(new PaperView());

			FlxG.sound.music.volume = 0;
		}
}