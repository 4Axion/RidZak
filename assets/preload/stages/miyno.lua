
function onCreate()
	-- le bg fuckin shit
	makeLuaSprite('bg', 'bgs/forgor/bg1', -950, -420);
	--0scaleObject('bg',1.3,1.2);
	--setLuaSpriteScrollFactor('bg', 0.9, 0.9);
	addLuaSprite('bg', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end