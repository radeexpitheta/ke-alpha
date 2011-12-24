function gadget:GetInfo()
  return {
    name      = "WeaponSetNeutral",
    desc      = "Sets Units to Neutral when gaia",
    author    = "TheFatController modified by quantum and bobthedino",
    date      = "25 Nov 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end


if (gadgetHandler:IsSyncedCode()) then

--SYNCED

---new system
function gadget:Initialize()
	Spring.SendCommands({'ally ' .. Spring.GetGaiaTeamID() .. ' 1' })
end

local SetUnitNeutral = Spring.SetUnitNeutral
local gaia = Spring.GetGaiaTeamID()
local toNeutralList = {}

function gadget:UnitCreated(u, ud, team)
		if ud.customParams and ud.customParams.weapon then			
			if ud.customParams.isweapon == 1 then
			SetUnitNeutral(u, true)		
			end
		end
end

function gadget:UnitGiven(u, ud, team, oldteam)	
	if ud.customParams and ud.customParams.weapon then			
			if ud.customParams.isweapon == 1 then
			SetUnitNeutral(u, true)		
			end
	end
end

function gadget:UnitTaken(u, ud, team, newteam)	
		if ud.customParams and ud.customParams.weapon then			
			if ud.customParams.isweapon == 1 then
			SetUnitNeutral(u, true)		
			end
		end
end

function gadget:GameFrame()
	for u,_ in pairs(toNeutralList) do
			SetUnitNeutral(u, true)
			toNeutralList[u] = nil
	end
end ---------------end of old system-----------


-----------------command invterventions--------------

-------------turn attack orders to capture orders
function gadget:AllowCommand(unitID, unitDefID, teamID, cmdID, cmdParams, cmdOptions)
  -- check if it's an attack order and there is only 1 param (multiple params mean the unit is attacking the ground)
	if cmdID == CMD.ATTACK and cmdParams[2] == nil then 
	---if cmdID == CMD.ATTACK then 
		--Spring.Echo('attacking?') 
		local targetID = cmdParams[1]
		local targetTeamID = Spring.GetUnitTeam(targetID)   
			if targetTeamID == gaia then
			--Spring.Echo('Attacking gaia?') 	
			local options = {}
				for key in pairs(cmdOptions) do
					table.insert(options, key)
				end    
				Spring.GiveOrderToUnit(unitID, CMD.LOAD, {targetID}, options)
				return false
			else
				return true
			end
	else
	return true
	end
	--------------change capture orders on player targets to attack---------------------
	----original if cmdID == CMD.CAPTURE and cmdParams[2] == nil then 
	if cmdID == CMD.CAPTURE then 
		---Spring.Echo('capturing?') 
		local ctargetID = cmdParams[1]
		local ctargetTeamID = Spring.GetUnitTeam(ctargetID)    
			if ctargetTeamID ~= gaia then
				---Spring.Echo('capturing enemy!?') 
				local coptions = {}
					for key in pairs(cmdOptions) do
					table.insert(coptions, key)
					end      
				Spring.GiveOrderToUnit(unitID, CMD.ATTACK, {ctargetID}, options)
				--return false
			else
				return true
			end
	else
	return true
	end
 end
 

else
--UNSYNCED

function gadget:Update()
end 

end