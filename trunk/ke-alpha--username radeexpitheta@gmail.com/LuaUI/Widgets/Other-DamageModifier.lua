function gadget:GetInfo()
	return {
		name = "classDamagemodifier",
		desc = "change damages to a unit depending on its group, and the attackers group",
		author = "Sean Heron", 
		date = "January 2009",
		license = "GNU GPL v2, or later",
		layer = 36, -- watchout for which layer!
		enabled = true
	}
end

local rand

local inf=UnitDefNames.inf.id
--local infb=UnitDefNames.infb.id


local crystal = UnitDefNames.crystal.id


local heros= {  
	[inf]=crystal,
	--[infb]=crystal,
}

if (gadgetHandler:IsSyncedCode()) then

--SYNCED

function gadget:UnitCreated(u, ud, team)  

end

function gadget:Initialize() 

end

function gadget:UnitPreDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponID, attackerID, attackerDefID, attackerTeam)

---Randomizer

rand = math.random(50,150) 
damage = damage * (rand / 100)
--Spring.Echo(damage) 
	
------- ENGINE armor

	if heros[unitDefID] and not heros[attackerDefID] then
		-- Spring.Echo("Engine taking damage")
		-- Spring.Echo("Engine taking damage from pawn")
		damage = damage * 0.8 -- pretty neat really :D - insane low for testing purposes
		-- Spring.Echo (damage)
	end
	
	return damage
	-- need to add the randomiser as well
	
end


-- function gadget:UnitPreDamaged(u,ud,team,damage,para,weapon,au,aud,ateam)
	-- if heros[ud] then
		-- --local h = Spring.GetUnitHealth(u)
		-- --Spring.SetUnitHealth(u, {health = h + damage})
		-- damage = 0
		-- Spring.Echo("This engine is invulnerable!")
		-- -- no damage at all
		
	-- end
	-- return damage
-- end


else
--UNSYNCED


function gadget:Update()

end

end
