
function onCreate()
	makeLuaSprite('bg', 'bgs/eerie/Eerie_bg_final_FINAL2', -480, -140);
	scaleObject('bg',0.6,0.6);
	--setLuaSpriteScrollFactor('bg', 0.9, 0.9);
	addLuaSprite('bg', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end