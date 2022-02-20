local penisx = -540
local penisy = -200
local penisSize = 1.85
local pf = 'bgs/ego/'
local mf = 'windows'
local curLight = 1;
local curScale = 0.8
local amazon = false
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
	makeLuaSprite('back', 'bgs/ego/back', penisx, penisy);
	--setLuaSpriteScrollFactor('back', 0.1, 0.1);
	makeLuaSprite('front', 'bgs/ego/front', penisx, penisy);
	scaleObject('front', penisSize, penisSize);

	--addLuaSprite('back', false);
	addLuaSprite('front', false);

	if (songName == 'Ego') then
	lem()
	end
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

function onEvent(eventName, value1, value2)
	if eventName == 'red done' then
		runTimer('toNorm',0.01,1)
	end
end

function onTimerCompleted(tag)
	if not amazon then
	if tag == 'toNorm' and getProperty('frontn.alpha') > 0.01 then
		lemo()
		runTimer('toNorm',0.01,1)
	elseif tag == 'toNorm' and getProperty('frontn.alpha') < 0.01 then
		lemoEnd()
		amazon = true
	end
	end
end

function lem()
	for i=1,4 do
		makeLuaSprite('pp' .. i, 'bgs/normal/' .. 'veryBack' .. i, -540, -200);
		scaleObject('pp' .. i, 1.85,1.85);
		addLuaSprite('pp' .. i, false);
		setProperty('pp' .. i .. '.visible',false)
			if (i == curLight) then
				setProperty('pp' .. i .. '.visible',true)
			end
	end
	makeLuaSprite('frontn', 'bgs/normal/front', penisx, penisy);
	scaleObject('frontn', penisSize, penisSize);
	addLuaSprite('frontn', false);
end

function lemo()
	for i=1,4 do
		setProperty('pp' .. i .. '.alpha',getProperty('pp' .. i .. '.alpha')-0.1)
	end
	setProperty('frontn.alpha',getProperty('frontn.alpha')-0.1)
end

function lemoEnd()
	for i=1,4 do
		removeLuaSprite('pp' .. i,true)
	end
	removeLuaSprite('frontn',true)
end