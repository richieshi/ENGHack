scriptId = 'com.project'

locked = true
getOut = false
inLoop = false
count = 0
unlockedSince = 0 
turn = false
lastTime = 0
previousTime = 0 
appTitle = ''
 
function onForegroundWindowChange(app, title)
	myo.debug("Title: " .. title)
	appTitle = title
	return true
end

function activeAppName()
	return appTitle
end

function onPoseEdge(pose, edge)
	pose = conditionallySwapWave(pose)
	if(edge == "on") then
		if (pose == "thumbToPinky") then
			toggleLock()
		end
		
		if (not locked) then
			if (pose == "waveIn" ) then
					nextSong() 
			elseif (pose == "waveOut") then
					prevSong() 
			elseif (pose == "fist") then
					play()
			elseif (pose == "fingersSpread") then
				initRoll = myo.getRoll()
				turn = true
			end			
		end
	else
		turn = false
	end
end

function toggleLock()
	locked = not locked
	if (locked) then
		myo.vibrate("short")
		myo.keyboard("left_alt", "down")
		while not (count == 0) do
			myo.keyboard("tab", "press")
			count = count - 1
		end
		myo.keyboard("left_alt", "up")		
		start = myo.getTimeMilliseconds()
		while (myo.getTimeMilliseconds() - start < 250) do
		end
	else
		myo.vibrate("medium")
		doTab = true
	end
end
 
function nextSong()
	myo.keyboard("right_arrow", "press")
end

function prevSong()
	myo.keyboard("left_arrow", "press")
end

function play()
	myo.keyboard("space", "press")
end

function adjustVolume()
	
end

function volumeDown()
	now = myo.getTimeMilliseconds()
	if (now - lastTime > 250) then
		myo.keyboard("down_arrow", "press", "control")
		lastTime = myo.getTimeMilliseconds()
	end
end

function volumeUp()
	now = myo.getTimeMilliseconds()
	if (now - lastTime > 250) then 
		myo.keyboard("up_arrow", "press", "control")
		lastTime = myo.getTimeMilliseconds()
	end 
end

function onPeriodic()
	if (turn) then		
	 	if (myo.getRoll() - initRoll > 0.1) then 
			volumeUp()
		elseif (myo.getRoll() - initRoll < -0.1) then 
			volumeDown() 
		end
	end
	
	if not (activeAppName() == "MiniPlayer")and doTab then
			count = count + 1
			myo.keyboard("left_alt", "down" )
			for i = 1, count, 1 do
				myo.keyboard("tab", "press")
			end
			myo.keyboard("left_alt", "up")
			start = myo.getTimeMilliseconds()
			while (myo.getTimeMilliseconds() - start < 250) do
			end
	else
		doTab = false
	end
end

function conditionallySwapWave(pose)
	if myo.getArm() == "left" then 
		if pose == "waveIn" then 
			pose = "waveOut"
		elseif pose == "waveOut" then
			pose = "waveIn"
		end
	end
	return pose
end																																																																																															