
local comboOvr = {}
function onCreate()
	-- le bg fuckin shit
	makeLuaSprite('back', 'bgs/bb/Back', -130, 200);
	--setLuaSpriteScrollFactor('back', 0.1, 0.1);
	scaleObject('back',1.5,1.5);

	makeLuaSprite('char', 'bgs/bb/Chair', 1130, 400);
	scaleObject('char',1.5,1.5);

	makeLuaSprite('desk', 'bgs/bb/Desk', -330, 600);
	--scaleObject('desk',1.5,1.5);

	
	addLuaSprite('back', false);
	addLuaSprite('char', true);
	addLuaSprite('desk', false);

	comboOvr[1] = 542
	comboOvr[2] = 236
	comboOvr[3] = 749
	comboOvr[4] = 301
	setProperty('comboArray', comboOvr)
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end