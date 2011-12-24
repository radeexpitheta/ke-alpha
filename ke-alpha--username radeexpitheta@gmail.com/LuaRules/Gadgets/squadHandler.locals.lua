--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Automatically generated local definitions

local CMD_ATTACK                = CMD.ATTACK
local CMD_FIRE_STATE            = CMD.FIRE_STATE
local CMD_MOVE_STATE            = CMD.MOVE_STATE
local CMD_STOP                  = CMD.STOP
local CMD_SELFD                 = CMD.SELFD
local spGetTeamColor            = Spring.GetTeamColor
local spGetUnitBasePosition     = Spring.GetUnitBasePosition
local spGetUnitCommands         = Spring.GetUnitCommands
local spGetUnitDefID            = Spring.GetUnitDefID
local spGetUnitDirection        = Spring.GetUnitDirection
local spGetUnitSeparation       = Spring.GetUnitSeparation
local spGetUnitEstimatedPath    = Spring.GetUnitEstimatedPath
local spGetUnitHeight           = Spring.GetUnitHeight
local spGetUnitPosition         = Spring.GetUnitPosition
local spGetUnitStates           = Spring.GetUnitStates
local spGetUnitTeam             = Spring.GetUnitTeam
local spGetVisibleUnits         = Spring.GetVisibleUnits
local spGiveOrderArrayToUnitMap = Spring.GiveOrderArrayToUnitMap
local spGiveOrderToUnit         = Spring.GiveOrderToUnit
local spSetUnitCOBValue         = Spring.SetUnitCOBValue
local spSetUnitMoveGoal         = Spring.SetUnitMoveGoal
local spSetUnitNoSelect         = Spring.SetUnitNoSelect
local spSetUnitTarget           = Spring.SetUnitTarget
local spGetLocalTeamID          = Spring.GetLocalTeamID

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
	return {
		name = "Squad Handler",
		desc = "was bored",
		author = "KDR_11k (David Becker)",
		date = "2008-10-21",
		license = "Public Domain",
		layer = 1,
		enabled = true
	}
end

if (gadgetHandler:IsSyncedCode()) then

--SYNCED

local moveDist=40 --Units will retake their position if they are further than this away from their position in the formation
local holdPosDist=250 --Units further away will be set to hold position so they stop moving away if they see enemies
local relativePos=false --Turn the formation with the leader?

local squads={}
local squadMember={}
local patterns={
	square={
		{80,0},{80,80},{0,80},{-80,80},{-80,0},{-80,-80},{0,-80},{80,-80},
	},
	triangle={
		{-40,60},{40,60},
	}
}
local CMD_JUMP = 32298

local forwardCommands={
	[CMD_STOP]=true,
	[CMD_JUMP]=1,
	[CMD_FIRE_STATE]=true,
	[CMD_MOVE_STATE]=true,
	[CMD_SELFD]=true,
}

local stopList={}
local orderRelayList={}
local commandList={}

local function AddUnitAt(u,i,leader)
	local ud = spGetUnitDefID(u)
	spSetUnitNoSelect(u,true)
	squadMember[u]={leader,i}
	squads[leader].followers[i]=u
	spSetUnitCOBValue(u,75,UnitDefs[ud].speed * 1.3 * 65536/32) --move 40% faster to allow catching up
end

local function RegisterSquad(type, leader, units)
	squads[leader] = {type=type, followers={}, pattern = UnitDefs[type].customParams.squadformation or "square"}
	for i,u in pairs(units) do
		AddUnitAt(u,i,leader)
	end
end

local function ConvertQueue(cmds)
	local newQ={}
	for i,d in ipairs(cmds) do
		newQ[i+1]={d.id,d.params,{"shift"}}
	end
	return newQ
end

local function RemoveUnit(u, ud, team)
	if squadMember[u] then
		local s = squadMember[u]
		squads[s[1]].followers[s[2]] = nil
		squadMember[u]=nil
	end
	if squads[u] then --was the squadleader
		local leader = nil
		local cmds = ConvertQueue(spGetUnitCommands(u))
		local x,y,z=spGetUnitPosition(u)
		cmds[1]={CMD.MOVE,{x,y,z},{}}
		local minDist=math.huge
		for i,tu in pairs(squads[u].followers) do
			local dist=spGetUnitSeparation(u,tu)
			if dist < minDist then
				leader = tu
				minDist= dist
			end
		end
		for i,tu in pairs(squads[u].followers) do
			if leader==tu then
				spSetUnitNoSelect(tu,false)
				spSetUnitCOBValue(tu,75,UnitDefs[ud].speed * 65536/32)
				squads[u].followers[i]=nil
				squadMember[tu]=nil
				squads[tu]=squads[u]
				leader=tu
				orderRelayList[tu]=cmds
			else
				squadMember[tu]={leader,i}
			end
		end
		squads[u]=nil
		SendToUnsynced("LeaderChanged",u,leader)
	end
end

function gadget:UnitDestroyed(u, ud, team)
	RemoveUnit(u,ud,team)
end

function gadget:AllowCommand(u, ud, team, cmd, param, opt, tag, synced)
	if not synced and squadMember[u] then
		return false
	end
	if squads[u] then
		if cmd == CMD_ATTACK then
			for i,fu in pairs(squads[u].followers) do
				if param[2] and param[3] then
					spSetUnitTarget(fu,param[1],param[2],param[3])
				else
					spSetUnitTarget(fu,param[1])
				end
			end
		elseif forwardCommands[cmd] and (synced == (forwardCommands[cmd]==1)) then
			for i,fu in pairs(squads[u].followers) do
				commandList[fu]={cmd,param,opt}
			end
		end
		return true
	end
	return true
end

function gadget:Initialize()
	GG.RegisterSquad=RegisterSquad
	GG.AddSquadUnitAt=AddUnitAt
	GG.RemoveSquadUnit=RemoveUnit
	GG.squads=squads
	_G.squads=squads
end

local function Pyth(x,ux,z,uz)
	return math.sqrt((x-ux)*(x-ux) + (z-uz)*(z-uz))
end

local function GetFormationPosition(pattern,posNr,x,z,dx,dz)
	local p = patterns[pattern][posNr]
	if relativePos then
		local rx,rz
		rx = -dz
		rz = dx
		return x + p[1]*rx + p[2]*dx, z + p[1]*rz + p[2]*dz
	else
		return x+p[1],z+p[2]
	end
end

function gadget:GameFrame(f)
	for u,_ in pairs(stopList) do
		spGiveOrderToUnit(u,CMD_STOP,{},{})
		stopList[u]=nil
	end
	for u,c in pairs(orderRelayList) do
		spGiveOrderArrayToUnitMap({[u]=true},c)
		orderRelayList[u]=nil
	end
	for u,d in pairs(commandList) do
		spGiveOrderToUnit(u,d[1],d[2],d[3])
		commandList[u]=nil
	end
	if f%59 < .1 then
		for leader,d in pairs(squads) do
			local wps, supp = spGetUnitEstimatedPath(leader)
			local ux,uy,uz = spGetUnitBasePosition(leader)
			local x,y,z
			local dx,dz
			local _,moveState = spGetUnitStates(leader)
			if wps and wps[supp[2]-1] then
				local p = wps[supp[2]-1]
				x=p[1]
				y=p[2]
				z=p[3]
				dist=Pyth(x,ux,z,uz)
				dx=(x-ux)/dist
				dz=(z-uz)/dist
			else
				x=ux
				y=uy
				z=uz
				dx,_,dz=spGetUnitDirection(leader)
			end
			for i,u in pairs(d.followers) do
				local fx,_,fz = spGetUnitPosition(u)
				local tx,tz=GetFormationPosition(d.pattern,i,x,z,dx,dz)
				local dist = Pyth(tx,fx,tz,fz)
				if dist > moveDist then
					spSetUnitMoveGoal(u,tx,0,tz)
				else
					spGiveOrderToUnit(u, CMD_MOVE_STATE,{moveState},{})
				end
				if dist > holdPosDist then
					spGiveOrderToUnit(u, CMD_MOVE_STATE,{0},{})
				end
			end
		end
	end
end

else

--UNSYNCED
local glBillboard               = gl.Billboard
local glColor                   = gl.Color
local glPopMatrix               = gl.PopMatrix
local glPushMatrix              = gl.PushMatrix
local glTexRect                 = gl.TexRect
local glTexture                 = gl.Texture
local glTranslate               = gl.Translate

local size=18
local offset=25

local squads

local squadIcon={
	[UnitDefNames.grunt.id]="icons/grunt.png",
	[UnitDefNames.jumper.id]="icons/jumper.png",
	[UnitDefNames.armor.id]="icons/armor.png",
	[UnitDefNames.recruit.id]="icons/recruit.png",
	[UnitDefNames.cutter.id]="icons/burner.png",
	[UnitDefNames.grenadier.id]="icons/grenadier.png",
}

function gadget:DrawScreenEffects(vsx,vsy)
	if not Spring.IsGUIHidden() then
		local localTeam = spGetLocalTeamID()
		for u,_ in spairs(squads) do
			local team=spGetUnitTeam(u)
			if team==localTeam then
				local x,y,z=spGetUnitBasePosition(u)
				local h = spGetUnitHeight(u)
				local r,g,b = spGetTeamColor(team)
				if Spring.IsUnitSelected(u) then
					r,g,b=1,1,1
				end
				local ud = spGetUnitDefID(u)
				glTexture(squadIcon[ud])
				glColor(r,g,b,1)
				glPushMatrix()
				local sx,sy,sz = Spring.WorldToScreenCoords(x,y+h+offset,z)
				glTranslate(sx,sy,sz)
				--glBillboard()
				glTexRect(-size, -size + offset, size, size + offset, false, false)
				glPopMatrix()
			end
		end
		glTexture(false)
	end
end

function gadget:Initialize()
	squads=SYNCED.squads
end

function gadget:RecvFromSynced(msg,from,to)
	if msg == "LeaderChanged" then
		if Spring.IsUnitSelected(from) then
			Spring.SelectUnitArray({to},true)
		end
	end
end

end
