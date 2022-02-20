local penisx = -600
local penisy = -100
local pf = 'bgs/cybbr/'
local mf = 'danceoff_front'
local curLight = 1;
local darkColor = '5d00ff'
local lightColor = 'ffffff'
function onCreate()
	-- le bg fuckin shit
	makeLuaSprite('back', 'bgs/cybbr/danceoff_back', penisx, penisy);
	--setLuaSpriteScrollFactor('back', 0.1, 0.1);
	--scaleObject('back', 1.3, 1);


	makeAnimatedLuaSprite('TheCameos1', 'bgs/cybbr/TheCameos1', penisx-100, penisy+240);
	scaleObject('TheCameos1', 1.2,1.2);
	luaSpriteAddAnimationByPrefix('TheCameos1', 'Idle', 'Idle'); 
	luaSpriteAddAnimationByPrefix('TheCameos1', 'Cheer', 'WOO'); 
		
	
	addLuaSprite('back', false);
	addLuaSprite('TheCameos1', false);

	makeLuaSprite('ldad', 'bgs/cybbr/LightCybbr', penisx, penisy);
	makeLuaSprite('lbf', 'bgs/cybbr/lightBf', penisx, penisy);
	setProperty('ldad.alpha',0.4)
	setProperty('lbf.alpha',0.4)
	setBlendMode('ldad', 'add')
	setBlendMode('lbf', 'add')
	addLuaSprite('ldad', true);
	addLuaSprite('lbf', true);
	setProperty('lbf.visible',false)
	setProperty('ldad.visible',false)

	for i=1,3 do
		makeLuaSprite('ww' .. i, pf .. mf .. i, penisx, penisy);
		--scaleObject('ww' .. i, 1.85,1.85);
		addLuaSprite('ww' .. i, false);
		setProperty('ww' .. i .. '.visible',false)
			if (i == curLight) then
				setProperty('ww' .. i .. '.visible',true)
			end
	end
end

function onEvent(eventName, value1, value2)
	if eventName == 'Play Animation' and value1 == 'cheer' then
		objectPlayAnimation('TheCameos1','Cheer',true)
		runTimer('resetCheer',1,1)
	end

	if value1 == 'cybbrg' or value2 == 'cybbrg' then
		triggerEvent('nosight','t','')
		removeLuaSprite('back', true);
		removeLuaSprite('TheCameos1', true);
		for i=1,3 do
			removeLuaSprite('ww' .. i, true);
		end
		makeLuaSprite('back', 'bgs/cybbr/danceoff_back2', penisx, penisy);
		makeAnimatedLuaSprite('TheCameos1', 'bgs/cybbr/TheCameos2', penisx-100, penisy+240);
		scaleObject('TheCameos1', 1.2,1.2);
		luaSpriteAddAnimationByPrefix('TheCameos1', 'Idle', 'Idle'); 
		luaSpriteAddAnimationByPrefix('TheCameos1', 'Cheer', 'WOO'); 
		addLuaSprite('back', false);
		addLuaSprite('TheCameos1', false);
		for i=1,3 do
			makeLuaSprite('ww' .. i, pf .. mf .. i, penisx, penisy);
			--scaleObject('ww' .. i, 1.85,1.85);
			addLuaSprite('ww' .. i, false);
			setProperty('ww' .. i .. '.visible',false)
				if (i == curLight) then
					setProperty('ww' .. i .. '.visible',true)
				end
		end
	end

	if eventName == 'FUCK YOU NO BLAMMED LIGHTS' and value2 == 'kys' then
		triggerEvent('nosight','no','')
	end

	if eventName == 'FUCK YOU NO BLAMMED LIGHTS' and value1 == 'turn on' then
		triggerEvent('Change Character','dad','cybbr-gold')
		triggerEvent('Change Character','gf','CYBgf')
		triggerEvent('Change Character','bf','bf')
		removeLuaSprite('back', true);
		removeLuaSprite('TheCameos1', true);
		for i=1,3 do
			removeLuaSprite('ww' .. i, true);
		end
		makeLuaSprite('back', 'bgs/cybbr/danceoff_back', penisx, penisy);
		makeAnimatedLuaSprite('TheCameos1', 'bgs/cybbr/TheCameos1', penisx-100, penisy+240);
		scaleObject('TheCameos1', 1.2,1.2);
		luaSpriteAddAnimationByPrefix('TheCameos1', 'Idle', 'Idle'); 
		luaSpriteAddAnimationByPrefix('TheCameos1', 'Cheer', 'WOO'); 
		addLuaSprite('back', false);
		addLuaSprite('TheCameos1', false);
		for i=1,3 do
			makeLuaSprite('ww' .. i, pf .. mf .. i, penisx, penisy);
			--scaleObject('ww' .. i, 1.85,1.85);
			addLuaSprite('ww' .. i, false);
			setProperty('ww' .. i .. '.visible',false)
				if (i == curLight) then
					setProperty('ww' .. i .. '.visible',true)
				end
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'resetCheer' then
		objectPlayAnimation('TheCameos1','Idle',true)
	end
end

function onMoveCamera(charCur)
	if charCur == 'boyfriend' then
	setProperty('lbf.visible',true)
	setProperty('ldad.visible',false)
	end

	if charCur == 'dad' then
	setProperty('ldad.visible',true)
	setProperty('lbf.visible',false)
	end
end

function onBeatHit(beat)
	if (curBeat % 4 == 0) then
		curLight = curLight+1;
		if (curLight == 4) then
			curLight = 1;
		end
		for i=1,3 do
		setProperty('ww' .. i .. '.visible',false)
			if (i == curLight) then
				setProperty('ww' .. i .. '.visible',true)
			end
		end
	end
end