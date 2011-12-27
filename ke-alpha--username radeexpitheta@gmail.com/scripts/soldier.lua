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
local w1a = "wrifle"
local w1b = "wsmg"
local w2a = "wshot"
local w3a = "wmgun"
local w4a = "wcshot"

-- flare position
local fy1a = 1.399
local fz1a = 12.709
local fy1b = 2.375
local fz1b = 7.206
local fy2 = 2.375
local fz2 = 7.206
local fy3 = 1.560
local fz3 = 19.749
local fy4 = 0.541
local fz4 = 13.736
---------------------------------------------------------------
local equip
local equipID

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

local function Hideall()
	Hide(rifle)
	Hide(smg)
	Hide(mgun)
	Hide(cshot)	
end

local function Inventory()
	Hideall()
	if equip == w1a then 
	  --  Spring.SetUnitWeaponState(unitID, 0, {sprayAngle = 20})
		Spring.SetUnitWeaponState(unitID, 0, {range = 600})
		Spring.SetUnitWeaponState(unitID, 0, {reloadTime = 2})
		Spring.SetUnitWeaponState(unitID, 0, {burst = 2})
		Spring.SetUnitWeaponState(unitID, 0, {burstRate = 0.3})
		Show(piece "rifle") 
		Move( flare, y_axis, fy1a, 999 )
		Move( flare, z_axis, fz1a, 999 )
	end
	if equip == w1b then 
	--	Spring.SetUnitWeaponState(unitID, 0, {sprayAngle = 50})
		Spring.SetUnitWeaponState(unitID, 0, {range = 300})
		Spring.SetUnitWeaponState(unitID, 0, {reloadTime = 0.3})
		Spring.SetUnitWeaponState(unitID, 0, {burst = 1})
		Show(piece "smg") 
		Move( flare, y_axis, fy1b, 999 )
		Move( flare, z_axis, fz1b, 999 )
	end
	if equip == w3a then 
		Show(piece "mgun") 
		Move( flare, y_axis, fy3, 999 )
		Move( flare, z_axis, fz3, 999 )
	end
	if equip == w4a then 
		Show(piece "cshot") 
		Move( flare, y_axis, fy4, 999 )
		Move( flare, z_axis, fz4, 999 )
	end		
	Spring.Echo ("equiped with: ", equip)
end

function script.Create()
	Hide(rot)
	Hide(blood)
	Hide(flare)
	Hide(shell)
	Hideall()
	bMoving = false
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
	if equip ~= nil then
		if (num == 1) then
			if not (equip == w1a or equip == w1b) then Spring.Echo("w1 fail") return false end
		end	
		if (num == 2) then
			if not (equip == w2a or equip == w2b) then return false end
		end	
		if (num == 3) then
			if not (equip == w3a or equip == w3b) then return false end
		end	
		if (num == 4) then
			if not (equip == w4a or equip == w4b) then return false end
		end	
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
	EmitSfx( flare,  1024+1 )   --emit flare
	--EmitSfx( shell,  1024+2 )   --emit shell
end

-------Transporting-----
function script.BeginTransport(passengerID)
end
function script.QueryTransport(passengerID)
	return -1
end
function script.EndTransport(each)
end

function script.TransportDrop (passengerID)
	--Spring.Echo ("Bye ", passengerID, "but is it ", equipID)	
	if (passengerID == equipID) then
		--Spring.Echo ("Bye weapon! Its a ", equip)		
		Hideall()
		equip = nil
		equipID = nil
	end	
	--Spring.UnitScript.DetachUnit(passengerID)
end

function script.TransportPickup (passengerID)	
	local oldgun = equip
	local oldID = equipID
	local unitDef = UnitDefs[Spring.GetUnitDefID(passengerID)]
	passengerteam = Spring.GetUnitAllyTeam (passengerID)
	Spring.Echo ("transport pick up")
	local udid = Spring.GetUnitDefID(passengerID)
	local pdef = UnitDefs[udid]
	if (pdef.name == w1a) or (pdef.name == w1b) or (pdef.name == w2a) or (pdef.name == w3a) or (pdef.name == w4a) then 
		Spring.Echo ("A weapon!! Yay! Its a ", pdef.name)	
		Spring.SetUnitNoSelect (passengerID, true)
		Spring.UnitScript.AttachUnit (-1, passengerID)
		equipID = passengerID 
		equip = pdef.name 
		if (oldID ~= nil) and (oldID ~= passengerID) then Spring.Echo("Too many items. Lets drop this ", oldgun, " ", oldID) Spring.UnitScript.DropUnit(oldID) end
		Inventory()
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
