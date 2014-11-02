scriptId = 'com.project'

locked = true
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
			previousTime = myo.getTimeMilliseconds()
			while (myo.getTimeMilliseconds() - previousTime < 3000) do 
				if (pose == "fingersSpread" and edge == "on") then
					toggleLock()
				end
			end
			myo.debug("end")
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

--[[function run(pose)
	
	if (previousGesture == pose) then
		if (timeSet == false) then
			previousGesture = pose
			setTime()
			timeSet = true
			return false
		elseif (timeSet == true) then
			if (myo.getTimeMilliseconds() - previousTime > 500) then
				return true
			else
				return false
			end
		end	
	else 
		timeSet = false
	end
end --]]

function setTime()
	previousTime = myo.getTimeMilliseconds
end 

function toggleLock()
	locked = not locked
	if (locked) then
		myo.vibrate("short")
	else
		myo.vibrate("medium")
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