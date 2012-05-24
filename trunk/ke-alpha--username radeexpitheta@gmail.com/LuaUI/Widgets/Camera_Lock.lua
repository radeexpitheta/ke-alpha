function widget:GetInfo()
	return {
		name = "locked view on hero",
		desc = "locks the view on the hero unit and makes a (hopefully) smooth camera movement in his moving direction",
		author = "Alfred Franz",
		date = "16 January 2009",
		license = "GNU GPL v2, or later",
		layer = 28,
		enabled = true
	}
end


--Made widget - so following  not needed atm
-- if (gadgetHandler:IsSyncedCode()) then
-- --SYNCED
	
-- else
-- --UNSYNCED

--######### hero unitdefs ###########
local hero= {
[UnitDefNames.inf.id]=UnitDefNames.inf.id,
--[UnitDefNames.infb.id]=UnitDefNames.infb.id,
}
--###################################

--######### local help variables ####
local heroID
local mult = 10
local direction
--###################################

-- "speedups"
local spGetCameraState   = Spring.GetCameraState
local spGetMouseState    = Spring.GetMouseState
local spIsAboveMiniMap   = Spring.IsAboveMiniMap
local spSendCommands     = Spring.SendCommands
local spSetCameraState   = Spring.SetCameraState

local yceiling = 1000 -- how high? dunno. this is how far up we let our user scroll
local current_cam_state = spGetCameraState()

function widget:Update()

	-- force total war cam
	if (current_cam_state.name ~= "ta") then
		spSendCommands({"viewta"})
		current_cam_state = spGetCameraState()      --this needed?  , ah, it's just updating the info! But as this is right at the end of the function, where current_cam_state is no longer used...
	end
	
	-----------------
	-- the main stuff

	local teamUnits = Spring.GetTeamUnits(Spring.GetMyTeamID())

	--in this case our hero is dead: do nothing!
	if (teamUnits.n < 2) then
		heroID = nil
		return nil
	end

	--if we don't know our heros ID yet, we've to find out whicht ID he has
	--please replace this code if you know a better way to do this!
	
	if (heroID==nil) then
		--dirty hack: we have to find out what's our hero, and don't select the start building which also is a unit
		if  (hero[Spring.GetUnitDefID(teamUnits[1])]~=nil) then
			heroID = teamUnits[1]
		else
			heroID = teamUnits[2]
		end
	end

	--get our hero's current position
	local heroX,heroY,heroZ = Spring.GetUnitPosition(heroID)

	--check out the velocity of our hero for the camera control
	local velX,velY,velZ
	if (Spring.GetUnitVelocity(heroID)~=0) then
		velX,velY,velZ = Spring.GetUnitVelocity(heroID)
	elseif (velX == nil) then
		velX,velY,velZ = Spring.GetUnitVelocity(heroID)
	end

	--control multifier for a smooth camera movement
	if  (Spring.GetUnitDirection(heroID)==direction) then
		if (mult < 50) then
			mult = mult + 0.3
		end
	else
		if (mult > 1) then
		mult = mult - 0.5
		end
	end
	direction = Spring.GetUnitDirection(heroID)
	--end

	--control camera
	Spring.SetCameraTarget(heroX+mult,heroY+mult,heroZ+mult)

	--always select hero 
	Spring.SelectUnitArray({heroID})
end



-- ok - we want to limit scrolling out to levels our models/ the game will still look good at
-- for every mousescroll - check if we let the user scroll out further
function widget:MouseWheel(up, value)
	current_cam_state = spGetCameraState()

 -- support function to work out if user is scrolling up or down
	local scrollvalue = Spring.GetConfigInt("ScrollWheelSpeed") -- do we have negative or positive scrollvalue + what is the value (important for finding out whether user is zooming in or out, and how far
	local scrollup
	if (up == false and scrollvalue <= 0 ) or (up == true and scrollvalue > 0 ) then        
        scrollup = true 	-- oops, had dropped this accidentily... well, works without, but is clearer what's happening this way
	else
		scrollup = false
	end 

	if (scrollup == true and yceiling < current_cam_state.py) then  -- if the cam position is higher than our declared ceiling, disallow zooming further
	   return true
	else
	   return false
	end

end




-- at the moment, this doesn't work as advertised, so commented out.

-- -- ok - we want to limit scrolling out to levels our models/ the game will still look good at
-- -- for every mousescroll - check if we let the user scroll out further
-- function widget:MouseWheel(up, value)

	-- local scrollvalue = Spring.GetConfigInt("ScrollWheelSpeed") -- do we have negative or positive scrollvalue + what is the value (important for finding out whether user is zooming in or out, and how far
	-- current_cam_state = spGetCameraState()

 -- -- support function, as I've not seen how I can find this out with a simple callin
	-- local scrollup = true
	-- if (up == false and scrollvalue <= 0 ) or (up == true and scrollvalue > 0 ) then        -- merde, value and up declare the same damn thing... so I always get true (using value) - well, found the access to the config file fast enough, so is okay!
        -- scrollup = true 	-- oops, had dropped this accidentily... well, works without, but is clearer what's happening this way
	-- else
		-- scrollup = false
	-- end 
	   
   	-- ----------
    -- -- okay, on top of having a smooth stop at the ceiling (see below), we'd also like to scroll at the map edges without being bumped inwards (and above all seeing the border...)

    -- --how much are we going to go up ?
	-- local mousescale = Spring.GetConfigString("RotOverheadMouseScale")  -- why is this to be found under UnsyncedCrlt in the Wiki... better question is why haven't I changed it yet...
	-- -- using mousescale at all ?
	-- local groundheight = Spring.GetGroundHeight(current_cam_state.px, current_cam_state.pz)  -- hope I'm not switching x and y here...
	
	-- local projectedheight = (current_cam_state.py - groundheight) * (1 + math.abs(scrollvalue) * mousescale ) + groundheight           -- this is according to the calculation the Rotatable Overview cam does - see the Engine C++ source (the cam bit) for details
	-- -- ok, this bit I'd want to change - to distance from Engine we're focused on, rather than absolute height (the calcs certainly aren't correct for non straight-upwards movement...)
	-- -- dur - the calculations are probably totally different for the ta cam :/
	
	-- if (scrollup == true) then
		-- if (yceiling < projectedheight) then                          -- otherwise we get bumpiness at top     
			-- projectedheight = yceiling                   -- hmm, if someone switches this widget on on the go it breaks ? perhaps, but as I plan to run from startup anyway, don't really care
		-- end
        -- spSetCameraState(current_cam_state, 0.2)        --should show same behaviour now, as setting from same place - please!
	 -- end       -- what's this doing here???              -- that does the trick, yipee!
	-- -----------

	-- if (scrollup == true and projectedheight >= yceiling) then  -- if the cam position would move higher than our declared ceiling, disallow zooming further and set camera to the ceiling
	   -- current_cam_state.py = yceiling
	   -- spSetCameraState(current_cam_state, 0.2)
	   -- return true
	-- else
	   -- return false
	-- end

-- end


-- end

