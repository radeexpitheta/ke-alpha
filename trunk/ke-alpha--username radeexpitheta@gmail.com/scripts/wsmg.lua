local base = piece 'base' 
local body = piece 'body' 

local function fall()
Turn( body, x_axis, math.rad(2), 1000 )
Turn( body, y_axis, math.rad(90), 1000 )
end


function script.Create()
---never mind
fall()
end

function script.AimWeapon(num, heading, pitch)
	if equip ~= nil then
		if Spring.GetUnitTransporter ~= nil then
			deploy()
			Signal(SIG_Aim)
			SetSignalMask(SIG_Aim)
			StartThread(RestoreAfterDelay)
			return true
		else
		return false 
		end
	else
	return false 
	end
end

function script.AimFromWeapon(num)
	return body		
end

function script.QueryWeapon(num)
	return body
end


