include "constants.lua"

--pieces
--body
local base = piece "base"
local head = piece "head"
local torso = piece "torso"
local pelvis = piece "pelvis"

--appendages
local larm = piece "larm"
local lleg = piece "lleg"
local lfoot = piece "lfoot"
local rarm = piece "rarm"
local rleg = piece "rleg"
local rfoot = piece "rfoot"

--weapons
local rifle = piece "rifle"
local smg = piece "smg"
local mgun = piece "mgun"
local cshot = piece "cshot"

--emitters
local rot = piece "rot"
local blood = piece "blood"
local flare = piece "flare"
local shell = piece "shell"

------------------------- [[ Weapon Data ]] --------------------
-- ids
local w1 = "wrifle"
local w2 = "wsmg"
local w3 = "wmgun"
local w4 = "wcshot"

-- flare position
local fy1 = 1.399
local fz1 = 12.709
local fy2 = 2.375
local fz2 = 7.206
local fy3 = 1.560
local fz3 = 19.749
local fy4 = 0.541
local fz4 = 13.736
---------------------------------------------------------------
local equipa
--local equipb

local PACE = 2.2

local SIG_Walk = 1
local SIG_Aim = 2

local function Walk()
	Signal(SIG_Walk)
	SetSignalMask(SIG_Walk)
	while true do
		Turn( torso, y_axis, -.25, 1 )
		Turn( head, y_axis, .25, 1 )
		Move( pelvis, y_axis, 2, 7 )
		
		Turn( larm, x_axis, .4, 2 )
		Turn( lleg, x_axis, -.5, 3 ) -- forward
		
		Turn( rarm, x_axis, -.5, 3 )
		Turn( rleg, x_axis, .5, 2 )
		
		WaitForMove( pelvis, y_axis )
		Move( pelvis, y_axis, 0, 8 )
		Sleep( 250 )
		
		Turn( torso, y_axis, .25, 1 )
		Turn( head, y_axis, -.25, 1 )
		Move( pelvis, y_axis, 2, 7 )
		
		Turn( larm, x_axis, -.5, 3 )
		Turn( lleg, x_axis, .5, 2 ) -- backwards
		
		Turn( rarm, x_axis, .4, 2 )
		Turn( rleg, x_axis, -.5, 3 )
		
		WaitForMove( pelvis, y_axis )
		Move( pelvis, y_axis, 0, 8 )
		Sleep( 250 )
	end
end

local function Inventory()
	Spring.Echo ("inventory started")
	while true do
		if equipa == w1 then 
			Show(piece "rifle") 
			Move( flare, y_axis, fy1, 999 )
			Move( flare, z_axis, fz1, 999 )
		end
		if equipa == w2 then 
			Show(piece "smg") 
			Move( flare, y_axis, fy2, 999 )
			Move( flare, z_axis, fz2, 999 )
		end
		if equipa == w3 then 
			Show(piece "mgun") 
			Move( flare, y_axis, fy3, 999 )
			Move( flare, z_axis, fz3, 999 )
		end
		if equipa == w4 then 
			Show(piece "cshot") 
			Move( flare, y_axis, fy4, 999 )
			Move( flare, z_axis, fz4, 999 )
		end		
		Spring.Echo ("equiped with: ", equipa)
		Spring.Echo ("w1 is: ", w1)
		Spring.Echo ("w2 is: ", w2)
		Spring.Echo ("w3 is: ", w3)
		Spring.Echo ("w4 is: ", w4)
		Sleep( 1250 )
	end
end

function script.Create()
	Hide(rot)
	Hide(blood)
	Hide(flare)
	Hide(shell)
	Hide(rifle)
	Hide(smg)
	Hide(mgun)
	Hide(cshot)	
	bMoving = false
	StartThread(Inventory)
end


local function RestoreAfterDelay()
	Sleep( 3000)
	Turn( rarm , y_axis, 0, math.rad(90) )
	Turn( rarm , x_axis, 0, math.rad(90) )
end

function script.StartMoving()
	StartThread(Walk)
end

function script.StopMoving()
	Signal(SIG_Walk)
	Turn( lleg, 1, 0, 3 )
	Turn( lleg, 2, 0, 1 )
	Turn( lleg, 3, 0, 1 )

	Turn( rleg, 1, 0, 3 )
	Turn( rleg, 2, 0, 1 )
	Turn( rleg, 3, 0, 1 )

	Turn( torso, y_axis, 0, 2 )
	Turn( head, y_axis, 0, 2 )
	Turn( head, x_axis, 0, 2 )
	Turn( head, z_axis, 0, 2 )
	
	Turn( larm, x_axis, 0, 2 )
	Turn( larm, y_axis, 0, 2 )
	Turn( larm, z_axis, 0, 2 )
	
	Turn( rarm, x_axis, 0, 2 )
	Turn( rarm, y_axis, 0, 2 )
	Turn( rarm, z_axis, 0, 2 )
end

function script.AimWeapon(num, heading, pitch)
	if equipa ~= nil then
		if (num == 1) and (equipa ~= w1)  then Spring.Echo ("no w1") return false end
		if (num == 2) and (equipa ~= w2)  then Spring.Echo ("no w2") return false end
		if (num == 3) and (equipa ~= w3)  then Spring.Echo ("no w3") return false end
		if (num == 4) and (equipa ~= w4)  then Spring.Echo ("no w4") return false end
		Signal(SIG_Aim)
		SetSignalMask(SIG_Aim)
		Turn( rarm , y_axis, heading, math.rad(360) ) -- left-right
		Turn( rarm , x_axis, -pitch, math.rad(270) ) --up-down
		WaitForTurn(rarm, y_axis)
		WaitForTurn(rarm, x_axis)
		StartThread(RestoreAfterDelay)
		return true
	else
	return false 
	end
end


function script.AimFromWeapon(num)
	return flare
end

function script.QueryWeapon(num)
	return flare
end

function script.Shot(num)
	EmitSfx( flare,  1024+0 )   --emit flare
	--EmitSfx( shell,  1024+1 )   --emit shell
end

-------Transporting-----
function script.BeginTransport(passengerID)
end
function script.QueryTransport(passengerID)
	return -1
end
function script.TransportDrop ( passengerID, x, y, z )
	Spring.Echo ("transport drop?")	
	--Spring.UnitScript.DetachUnit (passengerID)
end

function script.EndTransport(each, passengerID)
	local unitDef = UnitDefs[Spring.GetUnitDefID(passengerID)]
	passengerteam = Spring.GetUnitAllyTeam (passengerID)
	local udid = Spring.GetUnitDefID(passengerID)
	local pdef = UnitDefs[udid]
	if pdef.name == equipa then
		if equipa == "wrifle" then hide( rifle) equipa = nil end
		if equipa == "wsmg" then hide( smg) equipa = nil end
		if equipa == "wmgun" then hide( mgun) equipa = nil end
		if equipa == "wcshot" then hide( cshot) equipa = nil end
		Spring.Echo ("Bye weapon! Its a ", pdef.name)		
	end	
end

function script.TransportPickup (passengerID)	
	local unitDef = UnitDefs[Spring.GetUnitDefID(passengerID)]
	passengerteam = Spring.GetUnitAllyTeam (passengerID)
	Spring.Echo ("transport pick up")
	local udid = Spring.GetUnitDefID(passengerID)
	local pdef = UnitDefs[udid]
	if (pdef.name == w1) or 
	   (pdef.name == w2) or 
	   (pdef.name == w3) or 
	   (pdef.name == w4)
		then 
		Spring.Echo ("A weapon!! Yay! Its a ", pdef.name)	
		Spring.SetUnitNoSelect (passengerID, true)
		Spring.UnitScript.AttachUnit (-1, passengerID)
		if pdef.name ~= nil then equipa = pdef.name end
	else
	Spring.Echo ("not a weapon. Its a ", pdef.name)	
	end
end
------------------------



function script.Killed(recentDamage, maxHealth)
	local severity = recentDamage/maxHealth
	if severity <= .5  then
		EmitSfx( blood,  1024+0 )   --emit blood
		return 1
	else
		Explode(torso, sfxShatter)
		EmitSfx( blood,  1024+0 )   --emit blood
		EmitSfx( torso,  1024+0 )   --emit blood
		EmitSfx( head,  1024+0 )   --emit blood
		EmitSfx( pelvis,  1024+0 )   --emit blood
		EmitSfx( rarm,  1024+0 )   --emit blood
		EmitSfx( larm,  1024+0 )   --emit blood
		return 2
	end
end
