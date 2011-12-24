function widget:GetInfo()
	return {
		name = "Hotkeys",
		desc = "Adds hotkeys for various command",
		author = "Sean Heron and bobthedinosaur",
		date = "June 2010",
		license = "GNU GPL v2 or later",
		layer = -1,
		enabled = true
	}
end



local CMD_TOGGLE=35951
----local CMD_JUMP = 32298  ---- not used

local qPressed = 0
local ePressed = 0
--local dPressed = 0
local spacePressed = 0

-- there's a lua file we can include that has all the keys "numbers" saved under their "names" - include that.

function widget:Update()                                               ---0x066 is f
 
	--------General Hotkeys - for all Engines
	
	----TOGGLE weapon states  0x071 is q---------
if (Spring.GetKeyState(0x071) == true and qPressed == 0 ) then   
       qPressed = 3 --1
       local selectedunits = Spring.GetSelectedUnits()     
       for _,unitID in pairs(selectedunits) do
	   		Spring.GiveOrderToUnit(unitID,CMD_TOGGLE,{1},{}) 
       end
	end
    if (Spring.GetKeyState(0x071) == true and qPressed == 1 ) then    
	   	qPressed = 4 --0
	   	local selectedunits = Spring.GetSelectedUnits()
	   	for _,unitID in pairs(selectedunits) do
	   		Spring.GiveOrderToUnit(unitID,CMD_TOGGLE,{2},{}) 
	   	end
	end
	if (Spring.GetKeyState(0x071) == true and qPressed == 2 ) then    
	   	qPressed = 5 --0
	   	local selectedunits = Spring.GetSelectedUnits()
	   	for _,unitID in pairs(selectedunits) do
	   		Spring.GiveOrderToUnit(unitID,CMD_TOGGLE,{0},{}) 
	   	end
	end
	if (Spring.GetKeyState(0x071) == false and qPressed == 3 ) then 
	   qPressed = 1
	end
	if (Spring.GetKeyState(0x071) == false and qPressed == 4 ) then 
	   qPressed = 2
	end
	if (Spring.GetKeyState(0x071) == false and qPressed == 5 ) then 
	   qPressed = 0
	end
	
	
	----Toggle 2 posture state  0x020 is space---
if (Spring.GetKeyState(0x020) == true and spacePressed == 0 ) then   
       spacePressed = 3 --1
       local selectedunits = Spring.GetSelectedUnits()     
       for _,unitID in pairs(selectedunits) do
	   		Spring.GiveOrderToUnit(unitID,CMD_TOGGLE+1,{1},{}) 
       end
	end
    if (Spring.GetKeyState(0x020) == true and spacePressed == 1 ) then    
	   	spacePressed = 4 --0
	   	local selectedunits = Spring.GetSelectedUnits()
	   	for _,unitID in pairs(selectedunits) do
	   		Spring.GiveOrderToUnit(unitID,CMD_TOGGLE+1,{2},{}) 
	   	end
	end
	if (Spring.GetKeyState(0x020) == true and spacePressed == 2 ) then    
	   	spacePressed = 5 --0
	   	local selectedunits = Spring.GetSelectedUnits()
	   	for _,unitID in pairs(selectedunits) do
	   		Spring.GiveOrderToUnit(unitID,CMD_TOGGLE+1,{0},{}) 
	   	end
	end
	if (Spring.GetKeyState(0x020) == false and spacePressed == 3 ) then 
	   spacePressed = 1
	end
	if (Spring.GetKeyState(0x020) == false and spacePressed == 4 ) then 
	   spacePressed = 2
	end
	if (Spring.GetKeyState(0x020) == false and spacePressed == 5 ) then 
	   spacePressed = 0
	end	

	----toggle 3 0x064 is d
	if (Spring.GetKeyState(0x064) == true) then 
	-- dpressed = 1
	 local selectedunits = Spring.GetSelectedUnits()     
       for _,unitID in pairs(selectedunits) do
			Spring.GiveOrderToUnit(unitID,CMD_TOGGLE+2,{0},{}) 
       end
	end
	
	----toggle 4 0x065 is e
	if (Spring.GetKeyState(0x065) == true and ePressed == 0 ) then   
       ePressed = 3 --1
       local selectedunits = Spring.GetSelectedUnits()     
       for _,unitID in pairs(selectedunits) do
	   		Spring.GiveOrderToUnit(unitID,CMD_TOGGLE+3,{1},{}) 
       end
	end
    if (Spring.GetKeyState(0x065) == true and ePressed == 1 ) then    
	   	ePressed = 4 --0
	   	local selectedunits = Spring.GetSelectedUnits()
	   	for _,unitID in pairs(selectedunits) do
	   		Spring.GiveOrderToUnit(unitID,CMD_TOGGLE+3,{0},{}) 
	   	end
	end
	if (Spring.GetKeyState(0x065) == false and ePressed == 3 ) then 
	   ePressed = 1
	end
	if (Spring.GetKeyState(0x065) == false and ePressed == 4 ) then 
	   ePressed = 0
	end
	
end


