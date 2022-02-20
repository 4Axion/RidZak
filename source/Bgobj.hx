package;

import flixel.FlxG;
import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;

class Bgobj extends FlxSprite
{
	public var theName:String;
	public var isAnim:String;
	public var animName:String;
	public var originalwidth:Float;
	var didClip:Bool = false;
	var reloadAfter:String;
	public function new(x:Float, y:Float)
	{
        super(x, y);
	}

	override function update(elapsed:Float) {
		if (reloadAfter != theName)
			{
				if (isAnim != 'y')
				loadGraphic(Paths.image(theName));
				didClip = false;
				if (theName == 'OoogaBoogaNullValue')
					visible = false;
			}
			reloadAfter = theName;
		if (!didClip && isAnim == 'y')
			{
				this.frames = Paths.getSparrowAtlas(theName);
				this.animation.addByPrefix('idle', animName, 24, true);
				animation.play('idle', true);
				if (theName == 'OoogaBoogaNullValue')
					visible = false;
			}
	}
}
