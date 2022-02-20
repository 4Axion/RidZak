package arcade;

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

class PixelState extends PlatformerEngine
{
	public static var arcadeZoom:Float = 1.5;
	public static var amounless:Float = 0.5;
	//public var camGame:FlxCamera;
	override function create()
	{
		//camGame = new FlxCamera();
		//FlxG.cameras.reset(camGame);
		//FlxCamera.defaultCameras = [camGame];
		super.create();
		FlxG.sound.music.stop;
		FlxG.sound.playMusic(Paths.music('mainTheme', 'arcade'), 1, true);
		
		FlxTween.tween(FlxG.camera, {zoom: 0.95}, 0.3, {
			ease: FlxEase.quadInOut,
			startDelay: 0.2,
			onComplete: function(twn:FlxTween)
			{
				FlxTween.tween(FlxG.camera, {zoom: arcadeZoom+amounless}, 0.1, {
				});
			}
		});

		var overlayArcade:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Arcade', 'arcade'));
		overlayArcade.antialiasing = ClientPrefs.globalAntialiasing;
		overlayArcade.setGraphicSize(Std.int(1280/arcadeZoom), Std.int(720/arcadeZoom));
		overlayArcade.updateHitbox();
		overlayArcade.screenCenter();
		overlayArcade.scrollFactor.x = 0;
		overlayArcade.scrollFactor.y = 0;
		add(overlayArcade);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
