
function onCreate()
	makeLuaSprite('bg', 'bgs/eerie/Eerie_bg_final_FINAL', -250, -160);
	scaleObject('bg',1.65,1.65);
	--setLuaSpriteScrollFactor('bg', 0.9, 0.9);

	if not lowQuality then

		makeAnimatedLuaSprite('Peeps', 'bgs/eerie/Peeps', -150, 50);
		scaleObject('Peeps', 0.9,0.9);
		luaSpriteAddAnimationByPrefix('Peeps', 'Idle', 'people'); 
			
	end

	addLuaSprite('bg', false);
	addLuaSprite('Peeps', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end