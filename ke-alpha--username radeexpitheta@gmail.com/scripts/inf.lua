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
local w1 = wrifle
local w2 = wsmg
local w3 = wmgun
local w4 = wcshot

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
local equipa = nil 
--local equipb = nil

local PACE = 1.4

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

function script.Create()
	Hide( rot)
	Hide( blood)
	Hide( flare)
	Hide( shell)
	Hide( rifle)
	Hide( smg)
	Hide( mgun)
	Hide( cshot)	
	bMoving = false
	
end


local function RestoreAfterDelay()
	Sleep( 2750)
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
	local prime = nil
	if (equipa == wrifle) then prime = 1 end
	if (equipa == wrifle) then prime = 1 end
	if (equipa == wrifle) then prime = 1 end
	if (equipa == wrifle) then prime = 1 end
	if prime ~= nil then return false
		else
		Signal(SIG_Aim)
		SetSignalMask(SIG_Aim)
		Turn( rarm , y_axis, heading, math.rad(360) ) -- left-right
		Turn( rarm , x_axis, -pitch, math.rad(270) ) --up-down
		WaitForTurn(rarm, y_axis)
		WaitForTurn(rarm, x_axis)
		StartThread(RestoreAfterDelay)
		return true
	end
end

function script.AimFromWeapon(num)
	return fire
end

function script.QueryWeapon(num)
	return fire
end

function script.Shot(num)
	EmitSfx( flare,  1024+0 )   --emit flare
	--EmitSfx( shell,  1024+1 )   --emit shell
end

function script.BeginTransport(passengerID)
end
function script.QueryTransport(passengerID)
	return -1
end
function script.EndTransport(each, passengerID)
	local wepid = nil
	if (uid == wrifle) or (uid == wsmg) or (uid == wmgun) or (uid == wcshot)
		then 
		local sid = tostring(uid)
		wepid = string.find(sid, "%s*=%s*(%a+)")
		equipa = nil
		Hide( wepid)
	end
end
function script.TransportPickup (passengerID)
	--Spring.Echo ("hey passenger " .. passengerID)
	local uid = Spring.GetUnitDefID(passengerID)
	if (uid == wrifle) or (uid == wsmg) or (uid == wmgun) or (uid == wcshot)
		then 
		if equipa = uid
		local sid = tostring(uid)
		wepid = string.find(sid, "%s*=%s*(%a+)")
		Show( wepid)
		else equipa = nil 
	end
end

function script.Killed(recentDamage, maxHealth)
	local severity = recentDamage/maxHealth
	elseif  severity <= .50  then
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