local penisx = -500
local penisy = -230
local penisscale = 1.4
function onCreate()
	-- le bg fuckin shit
	makeLuaSprite('bg', 'bgs/vibeStage/back back', penisx, penisy);
	scaleObject('bg',penisscale,penisscale);
	addLuaSprite('bg', false);

	makeLuaSprite('back', 'bgs/vibeStage/back', penisx, penisy);
	scaleObject('back',penisscale,penisscale);
	addLuaSprite('back', false);

	makeLuaSprite('Front', 'bgs/vibeStage/Front', penisx, penisy);
	scaleObject('Front',penisscale,penisscale);
	addLuaSprite('Front', false);

	makeLuaSprite('overlay', 'bgs/vibeStage/overlay', penisx, penisy);
	scaleObject('overlay',penisscale,penisscale);
	addLuaSprite('overlay', true);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end