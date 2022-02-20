local penisx = -540
local penisy = -200
local penisSize = 1.85
local pf = 'bgs/normal/'
local mf = 'veryBack'
local curLight = 1;
function onCreate()
	--getProperty('gf.', )
	-- le bg fuckin shit
	if (songName == 'Ego') then
		pf = 'bgs/ego/';
		mf = 'windows'
	else
		pf = 'bgs/normal/';
		mf = 'veryBack'
	end

	for i=1,4 do
	debugPrint(pf .. mf .. i);
	makeLuaSprite('ww' .. i, pf .. mf .. i, getProperty('boyfriend.x'), getProperty('boyfriend.y'));
	addLuaSprite('ww' .. i, true);
	setProperty('ww' .. i .. '.visible',false)
		if (i == curLight) then
			setProperty('ww' .. i .. '.visible',true)
		end
	end
end