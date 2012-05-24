-----------sets up weapon stats for player characters

function DeployPlayerWep()

	if equip == wrifle then 
		  --  Spring.SetUnitWeaponState(unitID, 0, {sprayAngle = 20})
			Spring.SetUnitWeaponState(unitID, 0, {range = 600})
			Spring.SetUnitWeaponState(unitID, 0, {reloadTime = 2})
			Spring.SetUnitWeaponState(unitID, 0, {burst = 2})
			Spring.SetUnitWeaponState(unitID, 0, {burstRate = 0.3})
			Show(piece "prifle") 
			flare = piece "prifle"
			useflare = 1
			useshell = 1
			end
		if equip == wsmg then 
		--	Spring.SetUnitWeaponState(unitID, 0, {sprayAngle = 50})
			Spring.SetUnitWeaponState(unitID, 0, {range = 300})
			Spring.SetUnitWeaponState(unitID, 0, {reloadTime = 0.3})
			Spring.SetUnitWeaponState(unitID, 0, {burst = 1})
			Spring.SetUnitWeaponState(unitID, 0, {burstRate = 0})
			Show(piece "psmg") 
			flare = piece "psmg"
			useflare = 1
			useshell = 1
		end
		if equip == wmgun then 
			Show(piece "pmgun") 
			flare = piece "pmgun"
			useflare = 1
			useshell = 1
		end
		if equip == wcshot then 
			Spring.SetUnitWeaponState(unitID, 0, {sprayAngle = "50"})
			Spring.SetUnitWeaponState(unitID, 0, {range = 300})
			Spring.SetUnitWeaponState(unitID, 0, {reloadTime = 0.3})
			Spring.SetUnitWeaponState(unitID, 0, {burst = 8})
			Spring.SetUnitWeaponState(unitID, 0, {burstRate = 0})
			Show(piece "pcshot") 
			flare = piece "pcshot"
			useflare = 1
		end	
		if equip == wsword then 
			Show(piece "psword") 
			flare = piece "psword"
		end	
end