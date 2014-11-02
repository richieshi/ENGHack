scriptId = 'com.project'

locked = true
count = 0
unlockedSince = 0 
turn = false
lastTime = 0
previousTime = 0  
 
function onForegroundWindowChange(app, title)
	myo.debug("Title: " .. title)
	return true
end

function onPoseEdge(pose, edge)

	run = true
	
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
		while not count == 0 do
			myo.keyboard("tab", "press", "alt")
			count = count - 1
		end
	else
		myo.vibrate("medium")
		while not appTitle == "MiniPlayer" do
			count = count + 1
			for i = 0, count, 1 do
				myo.keyboard("tab", "press", "alt")
			end
		end
	end
end

function run() 
 
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