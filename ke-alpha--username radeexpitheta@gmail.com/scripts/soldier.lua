include "constants.lua"
include "PlayerWepDeploy.lua"

--pieces----------------------------------------
--body
local base = piece "base"
local head = piece "head"
local torso = piece "torso"
local pelvis = piece "pelvis"
local larm = piece "larm"
local lleg = piece "lleg"
local lfoot = piece "lfoot"
local rarm = piece "rarm"
local rleg = piece "rleg"
local rfoot = piece "rfoot"
local wep = piece "wep"

--weapons
local wep = piece "wep"

--equipment
local a2head = piece "a2head"
local a2torso= piece "a2torso"
local a3head = piece "a3head"
local a3larm = piece "a3larm"
local a3rarm = piece "a3rarm"

--emitters
local rot = piece "rot"
local blood = piece "blood"
-----------------------------------end of pieces---------------


--- list function
local function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end
-------------------------  Weapon and Item Data  -----------------------
--local w1a = "wsmg"  <<< old system
local isweapon = Set { "wsmg", "wrifle", "wbatrif", "wshot", "wcshot", "wmagnm", "wantim", "wsword" }
local isarmor = Set { "a2", "a3"}
local delay = 3000

-------------Behavior   Control locals --------------------------------------------------
local equip
local equipID
local armor
local armorID

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

local function HideallArm()
	Hide(a2head)
	Hide(a2torso)
	Hide(a3head)
	Hide(a3rarm)
	Hide(a3larm)	
end

local function Deploy()
	local newrange = Spring.GetUnitWeaponState(equipID, 1, {range})
	local newrange = Spring.GetUnitWeaponState(equipID, 1, {range})
	Spring.SetUnitWeaponState(unitID, 1, {range = newrange}) 
	if newreload ~= nil then 
		delay = (1000 + tonumber(newreload))
		else
		delay = 2000
	end
	Spring.Echo ("equiped with: ", equip)
end

local function DeployArmor()
HideallArm()
Spring.SetUnitArmored (UnitID, 1, 1) --default is 100
	if Armor == "A2" then
		Spring.SetUnitArmored (UnitID, 1, 0.5) --x2 resistance
		Show(piece "a2head") 
		Show(piece "a2torso") 
	end
	if Armor == "A3" then
		Spring.SetUnitArmored (UnitID, 1, 0.25) --x4 resistance
		Show(piece "a3head") 
		Show(piece "a2torso") 
		Show(piece "a3rarm") 
		Show(piece "a3larm") 
	end
	--more later
end

function script.Create()
	Hide(rot)
	Hide(blood)
	HideallArm()
	equipID = 0
	bMoving = false
end

local function RestoreAfterDelay()
	Sleep( delay)
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
		Signal(SIG_Aim)
		SetSignalMask(SIG_Aim)
		Turn( rarm , y_axis, heading, math.rad(360) ) -- left-right
		Turn( rarm , x_axis, -pitch, math.rad(270) ) --up-down
		WaitForTurn(rarm, y_axis)
		WaitForTurn(rarm, x_axis)
		StartThread(RestoreAfterDelay)
		local attackid = GetUnitValue(COB.TARGET_ID)
		Spring.Echo ("Mans attacking ", attackid)
		Spring.GiveOrderToUnit(equipID,CMD.INSERT,{0,CMD_ATTACK,attackid,{"alt"}})
		return true
	else
	return false 
	end
end


function script.AimFromWeapon(num)
	return wep		
end

function script.QueryWeapon(num)
	return wep
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
		equip = nil
		equipID = nil
	end	
	if (passengerID == armorID) then	
		HideallArm()
		armor = nil
		armorID = nil
	end	
	--Spring.UnitScript.DetachUnit(passengerID)
end

function script.TransportPickup (passengerID)	
	----store previous item info---
	local oldgun = equip
	local oldID = equipID
	local oldArmor = armor
	local oldArmorID = armorID
	--------------------------------
	local unitDef = UnitDefs[Spring.GetUnitDefID(passengerID)]
	passengerteam = Spring.GetUnitAllyTeam (passengerID)
	Spring.Echo ("transport pick up")
	local udid = Spring.GetUnitDefID(passengerID)
	local pdef = UnitDefs[udid]
	---check for wep
	if isweapon[pdef.name] then
		Spring.Echo ("A weapon! Its a ", pdef.name)	
		Spring.SetUnitNoSelect (passengerID, true)
		Spring.UnitScript.AttachUnit (wep, passengerID)
		if (oldID ~= nil) then
			if oldID ~= passengerID then 
				Spring.Echo("Too many items. Lets drop this ", oldgun, " ", oldID, "for this new weapon ", passengerID) 
				Spring.UnitScript.DropUnit(oldID) 
			end
			else
			equipID = passengerID 
			equip = pdef.name 
			Deploy()	
		end
	else
	Spring.Echo ("not a weapon. Its a ", pdef.name)	
	end
	--check for armor
	if isarmor[pdef.name] then
		Spring.Echo ("I got armor! Its a ", pdef.name)	
		Spring.SetUnitNoSelect (passengerID, true)
		Spring.UnitScript.AttachUnit (-1, passengerID)
		armorID = passengerID 
		armor = pdef.name 
		if (oldArmorID ~= nil) and (oldArmorID ~= passengerID) then Spring.Echo("Too many items. Lets drop this ", oldArmor, " ", oldArmorID) Spring.UnitScript.DropUnit(oldArmorID) end
		DeployArmor()
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
