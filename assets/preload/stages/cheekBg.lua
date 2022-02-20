
function onCreate()
	-- le bg fuckin shit
	makeLuaSprite('bg', 'bgs/cheeky/bigchungus', -670,-290);
	scaleObject('bg',1.4,1.4);
	--setLuaSpriteScrollFactor('bg', 0.9, 0.9);
	addLuaSprite('bg', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end