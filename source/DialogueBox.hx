package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	var fw:FlxSprite;

	public var finishThing:Void->Void;
	public var nextDialogueThing:Void->Void = null;
	public var skipDialogueThing:Void->Void = null;
	public var destroyRed:Void->Void;
	public var doTheCutscene:Void->Void;

	var portraitLeft:FlxSprite;
	var portrait:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;
	var curshit:Int;
	var curBg:String;
	var lastBg:String;
	var curSong:String;
	var talkingshit:FlxSound;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>, ?lesong:String = 'vibe', ?isIn:Bool = false)
	{
		super();
		curshit = 0;
		curSong = lesong.toLowerCase();

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		if (isIn && curSong != 'ego')
			{
				FlxG.sound.playMusic(Paths.music('jazzy_intro'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			}

		box = new FlxSprite(-20, 45);
		box.alpha = 0.6;
		
		var hasDialog = false;
			hasDialog = true;

			box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
			box.animation.addByPrefix('normalOpen', 'Text Box Appear instance 1', 24, false);
			box.animation.addByIndices('normal', 'Text Box Appear instance 1', [4], "", 24);

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
		portrait = new FlxSprite(0,0).loadGraphic('weeb/bfPortrait');
		add(portrait);

		fw = new FlxSprite(0,0).loadGraphic(Paths.image('fw'));
		fw.screenCenter();
		fw.antialiasing = ClientPrefs.globalAntialiasing;
		fw.visible = false;
		add(fw);
		
		box = new FlxSprite(70, 390);
		box.frames = Paths.getSparrowAtlas('speech_bubble');
		box.scrollFactor.set();
		box.antialiasing = ClientPrefs.globalAntialiasing;
		box.animation.addByPrefix('normal', 'speech bubble normal', 24);
		box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
		box.animation.addByPrefix('angry', 'AHH speech bubble', 24);
		box.animation.addByPrefix('angryOpen', 'speech bubble loud open', 24, false);
		box.animation.addByPrefix('center-normal', 'speech bubble middle', 24);
		box.animation.addByPrefix('center-normalOpen', 'Speech Bubble Middle Open', 24, false);
		box.animation.addByPrefix('center-angry', 'AHH Speech Bubble middle', 24);
		box.animation.addByPrefix('center-angryOpen', 'speech bubble Middle loud open', 24, false);
		box.setGraphicSize(Std.int(box.width * 1));
		box.updateHitbox();
		add(box);
		box.animation.play('normalOpen');

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(1042, 590).loadGraphic(Paths.getPath('images/weeb/pixelUI/hand_textbox.png', IMAGE));
		handSelect.setGraphicSize(Std.int(handSelect.width * PlayState.daPixelZoom * 0.9));
		handSelect.updateHitbox();
		handSelect.visible = false;
		//add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
						talkingshit = new FlxSound().loadEmbedded(Paths.sound('train_passes'));
						FlxG.sound.list.add(talkingshit);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;
	var dialogueEnded:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.visible = false;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			dialogueOpened = true;
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if(FlxG.keys.justPressed.ANY || diaSkip)
		{
			if (dialogueEnded)
			{
				remove(dialogue);
				if (dialogueList[1] == null && dialogueList[0] != null)
				{
					if (!isEnding)
					{
						isEnding = true;
						FlxG.sound.play(Paths.sound('clickText'), 0.8);	

						FlxG.sound.music.stop();

						new FlxTimer().start(0.1, function(tmr:FlxTimer)
						{
							var tweenDiatime = 0.2;
							FlxTween.tween(box, {alpha: 0}, tweenDiatime, {ease: FlxEase.quintOut});
							FlxTween.tween(bgFade, {alpha: 0}, tweenDiatime, {ease: FlxEase.quintOut});
							FlxTween.tween(portrait, {alpha: 0}, tweenDiatime, {ease: FlxEase.quintOut});
							FlxTween.tween(swagDialogue, {alpha: 0}, tweenDiatime, {ease: FlxEase.quintOut});
							FlxTween.tween(dropText, {alpha: 0}, tweenDiatime, {ease: FlxEase.quintOut});
						});

						switch (PlayState.SONG.song.toLowerCase()) {
							case 'ego':
								FlxG.sound.play(Paths.sound('egoFlash'));
								destroyRed();
						}

						new FlxTimer().start(0.3, function(tmr:FlxTimer)
						{
							finishThing();
							kill();
						});
					}
				}
				else
				{
					dialogueList.remove(dialogueList[0]);
					startDialogue();
					if (!diaSkip)
					FlxG.sound.play(Paths.sound('clickText'), 0.8);	
				}
			}
			else if (dialogueStarted)
			{
				if (!diaSkip)
				FlxG.sound.play(Paths.sound('clickText'), 0.8);	
				swagDialogue.skip();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;
	var diaSkip:Bool;

	function startDialogue():Void
	{
		cleanDialog();
		callm();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);
		diaSkip = false; // PROGRAMMING FROM 4AXION

		if (talkingshit.playing)
			{
				talkingshit.stop();
				talkingshit.time = 0;
			}

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);
		swagDialogue.completeCallback = function() {
			handSelect.visible = true;
			dialogueEnded = true;
		};

		handSelect.visible = false;
		dialogueEnded = false;
		if (lastBg != curBg)
			{
				switch (curBg)
				{
					case '-1':
						fw.visible = false;
					default:
						fw.visible = true;
						fw.loadGraphic(Paths.image('cutsceneImages/${curSong}/${curBg}'));
						fw.setGraphicSize(1280,720);
						fw.screenCenter();
				}
			}

		switch (curCharacter)
		{
			case 'snd':
				FlxG.sound.play(Paths.sound(dialogueList[0]), 0.8);	
				diaSkip = true;
			case 'no_portait':
				if (portrait != null)
					portrait.visible = false;
			default:
				remove(portrait);
				remove(box);
				var theProperties:Array<String> = CoolUtil.coolTextFile('assets/shared/images/portraits/${curCharacter}/info.txt');
				portrait = new FlxSprite(Std.parseFloat(theProperties[0]),Std.parseFloat(theProperties[1])).loadGraphic(Paths.image('portraits/${curCharacter}/port'));
				swagDialogue.color = FlxColor.fromString(theProperties[3].split(':')[1]);
				portrait.setGraphicSize(Std.int(portrait.width * Std.parseFloat(theProperties[2])));
				dropText.color = FlxColor.fromString(theProperties[3].split(':')[0]);
				portrait.visible = true;
				//swagDialogue.sounds = [FlxG.sound.load(Paths.sound('${curCharacter}Text'), 0.6)];
				/*if (!dialogueList[0].contains('...'))
					{
						curshit += 1;
						talkingshit.loadEmbedded(Paths.sound('va/song_${songSHIT}_part_${curshit}'));
						talkingshit.play(true);
						if (curshit == 6)
							{
								fw.visible = true;
							}
					}*/
				add(portrait);
				add(box);
		}
		box.alpha = 0.6;
		if (dialogueList[0] == '.' || dialogueList[0] == '. ' || dialogueList[0] == ' .')
			{
				portrait.visible = false;
				swagDialogue.visible = false;
				dropText.visible = false;
				box.visible = false;
			}
		else
			{
				portrait.visible = true;
				swagDialogue.visible = true;
				dropText.visible = true;
				box.visible = true;
			}
		if(nextDialogueThing != null) {
			nextDialogueThing();
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		curBg = splitName[2];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + splitName[2].length + 3).trim();
	}
	var callpiss:Int = 0;
	function callm()
		{
			trace('dia$callpiss');
			callpiss++;
		}
}
