--------------------------------------------------------------------------------

local unitName = "crystal"

--------------------------------------------------------------------------------

local unitDef = {
  bmcode             = "0",
  buildCostEnergy    = 0,
  buildCostMetal     = 6,
  builder            = false,
  buildTime          = 15,
  blocking			= false,
  category           = "FRIEND",
  description        = "scenery",
  downloadable       = "1",
  --buildingGroundDecalDecaySpeed = 0.01,
  --buildingGroundDecalSizeX = 18,
 -- buildingGroundDecalSizeY = 18,
  --buildingGroundDecalType = "spawn_decal.png",  
  footprintX         = 1,
  footprintZ         = 1,
  commander          = true, 
  	collisionvolumetype  = "box",
	collisionvolumescales = "1 1 1",
	collisionvolumeoffsets = "0 0 0",
  idleAutoHeal       = 0,
  iconType           = "crystal",
  levelGround        = true,
  maxDamage          = 500000000000,
  maxSlope           = 30.00,
  maxWaterDepth      = 0,
  name               = "crystal",
  objectName         = "structures/crystal.s3o",
  power              = 1,
  reclaimable        = false,
  script		 	 = "default.cob",  
  shootme            = "0",
  sightDistance      = 150.00,
  TEDClass           = "FORT",
  useBuildingGroundDecal = true,  
  yardMap            = "f",
  unitname			 = unitName,
  --customparams = {
  --	factionname		   = "structure",
  --},
}
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
