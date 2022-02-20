local lastCol = 0
local anger = 0.0001
local xx = 950;
local yy = 400;
local xx2 = 950;
local yy2 = 400;
local robozakOfs = 30; -- cam ofs
local bfOfs = 65; -- cam ofs
local ofs = 10; -- does not matter
local followchars = true;
local del = 0;
local del2 = 0;
local currentBeat = 0
local bfCol = false
local exAnger = 0.001
local useBgColor = false
local comboOvr = {}
function onCreate()--var rbegoback:BGSprite -- rbegobackdesat
end

function onCreatePost()
	--scaleObject('rbegoback', 0.7, 0.7)
	--scaleObject('dad', 1.1, 1.1)
	setProperty('dad.color',getColorFromHex('222222'))
	setProperty('boyfriend.visible',false)
	setProperty('camFollow.x',950)
	setProperty('camFollow.y',400)
	setProperty('isCameraOnForcedPos',true)
	setProperty('uiBack.visible',false)
	setProperty('timeBar.visible',false)
	setProperty('timeBarBG.visible',false)
	setProperty('timeTxt.visible',false)
	setProperty('badDmg', 34)
end

function onUpdate(elapsed)
	currentBeat = (getSongPosition() / 1000)*(bpm/60)
	notebar()
	camshit()
	--doTweenAngle('pp','rbegoback',5 * math.sin(currentBeat * 0.504),0.000001,'quadout') 
		setProperty('camHUD.angle',(anger*100)+1 * math.sin(currentBeat * 0.504))
	if (bfCol) then
		if (getProperty('health') > 0.1) then
			addHealth((exAnger/2)*-1)
		end
		setProperty('iconP1.y', (getProperty('healthBar.y')- 75)+math.random(-5, 5))
	else
		if (getProperty('health') < 1.5) then
			addHealth((exAnger/2))
		end
	end

	if (curStep == 125) then
	setBlendMode('dad', 'add')
	setProperty('defaultCamZoom',0.8)
	setProperty('dad.color',getColorFromHex('FFFFFF'))
	triggerEvent('Add Camera Zoom','','0.006')
	setProperty('diffitext.visible',false)
	end

	if (curStep == 129) then
	setProperty('defaultCamZoom',0.6)
	end

	if (curStep == 256) then
		triggerEvent('spin the fucker',1.32,360)
		useBgColor = true
	end

	if (curStep == 271) then
		setProperty('doPussyAngle',true)
		useBgColor = false
	end

	if (curStep == 649) then
		triggerEvent('spin the fucker',1.9,-360)
		useBgColor = true
	end

	if (curStep == 671) then
		setProperty('doPussyAngle',true)
		useBgColor = false
	end

	if (curStep == 775) then
		triggerEvent('spin the fucker',0.7,720)
		useBgColor = true
	end

	if (curStep == 784) then
		triggerEvent('spin the fucker',0.7,720)
		useBgColor = true
	end

	if (curStep == 792) then
		setProperty('doPussyAngle',true)
		useBgColor = false
	end

	if (curStep == 800) then
		triggerEvent('spin the fucker',0.7,540)
		useBgColor = true
	end

	if (curStep == 808) then
		triggerEvent('spin the fucker',0.7,540)
		useBgColor = true
	end

	if (curStep == 816) then
		setProperty('doPussyAngle',true)
		useBgColor = false
	end

	if (curStep == 1024) then
		triggerEvent('spin the fucker',1.32,360)
		useBgColor = true
	end

	if (curStep == 1040) then
		setProperty('doPussyAngle',true)
		useBgColor = false
	end

	if (curStep == 1424) then
		triggerEvent('spin the fucker',1.32,720)
		useBgColor = true
	end

	if (curStep == 1440) then
		setProperty('doPussyAngle',true)
	end

	if (curStep == 1532) then
		useBgColor = false
	end

	if (curStep == 1536) then
		setProperty('dad.color',getColorFromHex('333333'))
		triggerEvent('Add Camera Zoom','','0.006')
	end
	if (curStep == 1536) then
		setProperty('dad.color',getColorFromHex('222222'))
	end
	if (curStep == 1537) then
		setProperty('dad.color',getColorFromHex('111111'))
	end
	if (curStep == 1538) then
		setProperty('dad.color',getColorFromHex('000000'))
	end
end

 -- spin event,
 -- triggerEvent('spin the fucker',TIME,ANGLE)

function goodNoteHit(index,data,type,sus)
	if (bfCol) then
		local tempArray = {}
		tempArray[1] = 49
		tempArray[2] = 176
		tempArray[3] = 209
	setProperty('iconP1.color', getColorFromHex('ffffff'))
	setProperty('boyfriend.healthColorArray', tempArray)
	setProperty('doHealthBarReload', true) -- made a source thing for this
	setProperty('iconP1.y', (getProperty('healthBar.y')- 75))
	bfCol = false
	end
end

function opponentNoteHit(index,data,type,sus)
		if (getProperty('health') > 0.1) then
		addHealth((0.01+anger+exAnger)*-1) --exAnger
		end
end

function notebar()
	local curCol = 0;
	local cccArray = {};
	local hexVers = '';
	if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
		curCol = 0
		cccArray[1] = 166
		cccArray[2] = 43
		cccArray[3] = 124
		hexVers = 'a62b7c'
	end
	if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
		curCol = 1
		cccArray[1] = 249
		cccArray[2] = 57
		cccArray[3] = 63
		hexVers = 'f9393f'
	end
	if getProperty('dad.animation.curAnim.name') == 'singUP' then
		curCol = 2
		cccArray[1] = 18
		cccArray[2] = 250
		cccArray[3] = 5
		hexVers = '12fa05'
	end
	if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
		curCol = 3
		cccArray[1] = 0
		cccArray[2] = 255
		cccArray[3] = 255
		hexVers = '00ffff'
	end
	if getProperty('dad.animation.curAnim.name') == 'idle' then
		curCol = 4
		cccArray[1] = 93
		cccArray[2] = 0
		cccArray[3] = 255 --#5d00ff
		hexVers = 'FFFFFF' 
	end
	if lastCol == curCol then
		lastCol = curCol
	else
		lastCol = curCol

		if curCol == 4 then
			lastCol = curCol
		else
			local tempArray = {}
			tempArray[1] = 93
			tempArray[2] = 0
			tempArray[3] = 255
		setProperty('iconP1.color', getColorFromHex('5d00ff'))
		setProperty('boyfriend.healthColorArray', tempArray)
		bfCol = true
		end

		if curCol == 4 then
			lastCol = curCol
			setProperty('doVissy', false)
		else
			if useBgColor then
			setProperty('doVissy', true)
			setProperty('colBitch', getColorFromHex(hexVers))
			end
		end
		--setProperty('iconP2.color', getColorFromHex(hexVers))
		--for i=0,7 do
		--	setProperty('.color', getColorFromHex(hexVers))
		--end
		setProperty('dad.healthColorArray', cccArray)
		setProperty('doHealthBarReload', true) -- made a source thing for this
		anger = anger+0.00002
	end
end

function camshit()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.6)
			ofs = robozakOfs;
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else
            setProperty('defaultCamZoom',0.55)
			ofs = bfOfs;
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            --if getProperty('dad.animation.curAnim.name') == 'idle' then
            --    triggerEvent('Camera Follow Pos',xx2,yy2)
            --end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
end