local penisx = -540
local penisy = -200
local penisSize = 1.85
local pf = 'bgs/normal/'
local mf = 'veryBack'
local curLight = 1;
local curScale = 0.8
function onCreate()
	--getProperty('gf.', )
	scaleObject('gf', 0.8,0.8);
	-- le bg fuckin shit
	for i=1,4 do
		makeLuaSprite('ww' .. i, pf .. mf .. i, -540, -200);
		scaleObject('ww' .. i, 1.85,1.85);
		addLuaSprite('ww' .. i, false);
		setProperty('ww' .. i .. '.visible',false)
			if (i == curLight) then
				setProperty('ww' .. i .. '.visible',true)
			end
	end

	makeLuaSprite('back', 'bgs/normal/back', penisx, penisy);
	--setLuaSpriteScrollFactor('back', 0.1, 0.1);
	makeLuaSprite('front', 'bgs/normal/front', penisx, penisy);
	scaleObject('front', penisSize, penisSize);

	--addLuaSprite('back', false);
	addLuaSprite('front', false);

end

function onBeatHit(beat)
	if (curBeat % 4 == 0) then
		curLight = curLight+1;
		if (curLight == 5) then
			curLight = 1;
		end
		for i=1,4 do
		setProperty('ww' .. i .. '.visible',false)
			if (i == curLight) then
				setProperty('ww' .. i .. '.visible',true)
			end
		end
	end
end