
function onCreate()
	-- le bg fuckin shit
	makeLuaSprite('back', 'bgs/anders/ANDERSSSSSSSSS', -600, -300);
	scaleObject('back',0.64,0.64);

	addLuaSprite('back', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end