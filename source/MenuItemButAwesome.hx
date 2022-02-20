package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class MenuItemButAwesome extends FlxSpriteGroup
{
	public var defSize:Float = 0;
	public var targetY:Float = 0;
	public var week:FlxSprite;
	public var flashingInt:Int = 0;
	public var big:Bool = false;
	var resc:Float;
	var pissoffsets:Float;

	public function new(x:Float, y:Float, weekNum:Int = 0, char:String, ?rescale:Float = 1, ?offttttttt:Float = 430)
	{
		super(x, y);
		resc = rescale;
		pissoffsets = offttttttt;
		week = new FlxSprite().loadGraphic(Paths.image('poopoopeepee/' + char, 'ridzak'));
		add(week);
	}

	private var isFlashing:Bool = false;

	public function startFlashing():Void
	{
		isFlashing = true;
	}

	// if it runs at 60fps, fake framerate will be 6
	// if it runs at 144 fps, fake framerate will be like 14, and will update the graphic every 0.016666 * 3 seconds still???
	// so it runs basically every so many seconds, not dependant on framerate??
	// I'm still learning how math works thanks whoever is reading this lol
	var fakeFramerate:Int = Math.round((1 / FlxG.elapsed) / 10);
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (targetY == -2)
			targetY = 1;
		if (targetY == 2)
			targetY = -1;
		x = FlxMath.lerp(x, (targetY * 400) - pissoffsets, 0.1); // LERPS THE X TO NEW TARGET
		if (big) {
			scale.x = FlxMath.lerp(scale.x, 0.6*resc, 0.3);
			scale.y = FlxMath.lerp(scale.y, 0.6*resc, 0.3);
		} else {
			scale.x = FlxMath.lerp(scale.x, 0.5*resc, 0.3);
			scale.y = FlxMath.lerp(scale.y, 0.5*resc, 0.3);
		}
		if (isFlashing)
			flashingInt += 1;

		if (flashingInt % fakeFramerate >= Math.floor(fakeFramerate / 2))
			week.color = 0xFF33ffff;
		else
			week.color = FlxColor.WHITE;
	}
}
