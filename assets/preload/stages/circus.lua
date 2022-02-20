local penisx = -600
local penisy = -400
local penisSize = 0.66
function onCreate()
	-- le bg fuckin shit
	makeLuaSprite('back', 'bgs/stixs/back', penisx, penisy);
	--setLuaSpriteScrollFactor('back', 0.1, 0.1);
	scaleObject('back', penisSize,penisSize);

	makeLuaSprite('lightb', 'bgs/stixs/backlight', penisx, penisy);
	scaleObject('lightb', penisSize,penisSize);

	makeLuaSprite('front', 'bgs/stixs/Front', penisx, penisy+50);
	scaleObject('front', penisSize-0.03,penisSize-0.03);

	makeLuaSprite('front2', 'bgs/stixs/Front2', penisx, penisy+50);
	scaleObject('front2', penisSize-0.03,penisSize-0.03);


	if not lowQuality then

	makeAnimatedLuaSprite('peep', 'bgs/stixs/biggerpoepl', penisx-60, penisy+680);
	scaleObject('peep', 0.74,0.74);
	luaSpriteAddAnimationByPrefix('peep', 'Sy', 'Sy');
		
	end
	
	addLuaSprite('back', false);
	addLuaSprite('lightb', false);
	addLuaSprite('peep', false);
	addLuaSprite('front', false);
	addLuaSprite('front2', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end