local penisx = -600
local penisy = -400
function onCreate()
	-- le bg fuckin shit
	makeLuaSprite('bg', 'bgs/syn/SynTech', -400, -300);
	scaleObject('bg',0.7,0.7);
	setLuaSpriteScrollFactor('bg', 0.9, 0.9);

	makeLuaSprite('wires', 'bgs/syn/SynTechwires', -500, -70);
	scaleObject('wires',0.7,0.7);
	setLuaSpriteScrollFactor('wires', 1.3,1.3); --NOOO STEP-SNUSSY TECHHHHH IT WASNT MEEEE I WAS IN ELECTRICAL FIXING WIRES :(((((

	addLuaSprite('bg', false);
	addLuaSprite('wires', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end