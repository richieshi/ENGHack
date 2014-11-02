scriptId = 'com.project'

locked = true
unlockedSince = 0 
turnn = false
 
function onForegroundWindowChange(app, title)
	myo.debug("Title: " .. title)
	return true
end

function onPoseEdge(pose, edge)

	run = true
	
	if(edge == "on") then
		if (pose == "thumbToPinky") then
			toggleLock()
		end
		
		if (not locked) then
			if (pose == "waveIn") then
				nextSong()
			elseif (pose == "waveOut") then
				prevSong()
			elseif (pose == "fist") then
				play()
			elseif (pose == "fingersSpread") then
				initYaw = myo.getYaw()
				turn = true
			end			
		end
	else
		if (pose == "fingersSpread") then
			turn = false
		end
	end
end

function toggleLock()
	locked = not locked
	if (locked) then
		myo.vibrate("short")
	else
		myo.vibrate("medium")
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

function onPerodic()
	if (turn) then
		myo.debug(myo.getYaw - initYaw)
	end
end