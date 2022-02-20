package;

import FlxVideo;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;

#if sys
import sys.FileSystem;
#end

using StringTools;

class PlayMedia extends MusicBeatState
{
    public static var di:Array<String>;
    var video:FlxVideo;
    override function create() 
        {
            switch (di[0])
            {
                case 'video':
                    startVideo(di[1]);
				case 'image':
					displayImage(di[1]);
				case 'image&audio':
					displayImage(di[1].split('_')[0]);
					FlxG.sound.playMusic(Paths.music(di[1].split('_')[1]));
            }
        }

	var vidFin:Bool = false;
    override function update(elapsed:Float)
        {
			if (controls.BACK || controls.ACCEPT)
				{
					FlxG.sound.music.stop();
					returnto(${di[2]});
				}
        }

    function returnto(name:String)
        {
            switch (name)
            {
                case 'coderoom':
                    LoadingState.loadAndSwitchState(new CodeShit());
            }
        }

	function displayImage(pathImg:String)
		{
			var image:FlxSprite = new FlxSprite().loadGraphic(Paths.image('secret/${pathImg}', 'ridzak'));
			image.antialiasing = ClientPrefs.globalAntialiasing;
			image.setGraphicSize(1280,720);
			image.screenCenter();
			add(image);
		}
		var bg:FlxSprite;
	public function startVideo(name:String):Void 
        {
		#if VIDEOS_ALLOWED
		var foundFile:Bool = false;
		var fileName:String = #if MODS_ALLOWED Paths.modFolders('videos/' + name + '.' + Paths.VIDEO_EXT); #else ''; #end
		#if sys
		if(FileSystem.exists(fileName)) {
			foundFile = true;
		}
		#end

		if(!foundFile) 
            {
	            	fileName = Paths.video(name);
	            	#if sys
	            	if(FileSystem.exists(fileName)) {
	            	#else
	            	if(OpenFlAssets.exists(fileName)) {
	            	#end
	            		foundFile = true;
	            	}
	            }

	            if(foundFile) {
	            	bg = new FlxSprite(-FlxG.width, -FlxG.height).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
	            	bg.scrollFactor.set();
	            	add(bg);

	            	(new FlxVideo(fileName)).finishCallback = function() {
                        returnto(di[2]);
	            	}
	            	return;
	            } else {
	            	FlxG.log.warn('Couldnt find video file: ' + fileName);
	            }
	            #end
                returnto(di[2]);
	        }
        }