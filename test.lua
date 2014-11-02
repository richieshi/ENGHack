
scriptId = 'com.project'

mouseControl = false
locked = false
scroll = false
 
function onForegroundWindowChange(app, title)
	return true
end

function onFist()
	if (mouseControl) then
		myo.controlMouse(false)
		mouseControl = false
	else
		myo.controlMouse(true)
		mouseControl = true
	end
end

function onWaveIn()
	myo.keyboard("down_arrow", "down")
end

function offWaveIn()
	myo.keyboard("down_arrow", "up")
end

function onThumbToPinky()
	
end

function onPoseEdge(pose, edge)
	if (pose == "waveIn" and edge == "on") then
		onWaveIn()
	elseif(pose == "waveIn" and edge == "off") then
		offWaveIn()
	end
	
	if(pose == "fist" and edge == "on") then
		onFist()
	elseif (pose == "thumbToPinky" and edge == "on") then
		onThumbToPinky()
	end
end
