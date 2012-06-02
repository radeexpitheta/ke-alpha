-- UNITDEF -- wrifle --
--------------------------------------------------------------------------------

local unitName = "wrifle"

--------------------------------------------------------------------------------

local unitDef = {
	unitname           = [[wrifle]],
	name               = [[Rifle]],
	description        = [[Weapon]],	
	--iconType		    = "weapon",
   -- acceleration        = 0,
  --bmcode              = [[1]],
  --brakeRate           = 0,
  buildCostMetal     = 0,
  canMove 			 = true,
  canstop            = true,
  category           = [[NOTARGET]],
  capturable = false,	
  customParams = {
		isweapon = 1,
		},	
  defaultmissiontype    = [[Standby]],
  explodeAs          = [[NullDeath]],
  footprintX         = 1,
  footprintZ         = 1,
  hidedamage		 = 1,
  maneuverleashlength = [[1]],
  mass				 = 5,
  maxDamage          = 8000,
  maxSlope           = 255,
  maxVelocity         = 0.0000001,
  maxWaterDepth       = 10,
  movementClass       = [[Foot]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[NOTARGET]],
  objectName         = [[wrifle.s3o]],
  pushResistant      = true,
  radarDistance      = 0,
  script             = [[weapon.lua]],
  selfDestructAs     = [[NullDeath]],
  selfDestructCountdown = 0,
  showNanoFrame      = false,
  sightDistance      = 0,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  TurnRate 			 = 1,

}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
