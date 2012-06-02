local base = piece 'base' 
local body = piece 'body' 

local active

local function drop()
active = false
Turn( body, x_axis, math.rad(4), 9000 )
Turn( body, z_axis, math.rad(90), 9000 )
end

local function deploy()
active = true
Turn( body, x_axis, math.rad(0), 9000 )
Turn( body, z_axis, math.rad(0), 9000 )
end

local function check()
	while true do
		if (Spring.GetUnitTransporter ~= nil) and (active == false) then
			deploy()
		else
			if (Spring.GetUnitTransporter == nil) and (active == true) then drop() end
		end
		Sleep( 800 )
	end
end

function script.Create()
---never mind0
active = false --only first run
drop()
check()
end

function script.AimWeapon(num, heading, pitch)
	if active == true then
		local atid = GetUnitValue(COB.TARGET_ID) 
		Spring.Echo ("Wep attacking ", atid)
		return true
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


