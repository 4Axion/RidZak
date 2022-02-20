package;

import flixel.FlxG;
import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;

class Button extends FlxSprite
{
	public var interactable:Bool;
	public var buttonfunction:String;
	public function new(x:Float, y:Float, ?btnType:Bool = false, ?leFunction:String = 'no')
	{
		interactable = btnType;
		buttonfunction = leFunction;
        super(x, y);
	}
}
