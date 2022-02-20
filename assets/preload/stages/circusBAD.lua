local penisx = -600
local penisy = -400
local penisSize = 0.66
function onCreate()
	-- le bg fuckin shit
	makeLuaSprite('back', 'bgs/stixsBad/back', penisx, penisy);
	--setLuaSpriteScrollFactor('back', 0.1, 0.1);
	scaleObject('back', penisSize,penisSize);

	makeLuaSprite('front', 'bgs/stixsBad/front', penisx, penisy+50);
	scaleObject('front', penisSize-0.03,penisSize-0.03);
	
	addLuaSprite('back', false);
	addLuaSprite('front', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end