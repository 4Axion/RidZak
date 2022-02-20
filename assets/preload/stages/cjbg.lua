
function onCreate()
	-- le bg fuckin shit
	makeLuaSprite('back', 'bgs/CJbg/cj', -600, -100);
	scaleObject('back',0.6,0.6);
	addLuaSprite('back', false);

	if not lowQuality then

	makeAnimatedLuaSprite('fans', 'bgs/CJbg/FANZ', -500, 450);
	scaleObject('fans', 1.1,1.1);
	luaSpriteAddAnimationByPrefix('fans', 'Idle', 'S');
	addLuaSprite('fans', true); 
		
	end
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end