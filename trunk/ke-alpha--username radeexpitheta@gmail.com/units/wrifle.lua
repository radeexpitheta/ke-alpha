-- UNITDEF -- medbox --
--------------------------------------------------------------------------------

local unitName = "medbox"

--------------------------------------------------------------------------------

local unitDef = {
  buildCostMetal     = 0,
  canstop            = false,
  CantBeTransported = true,
  category           = [[NOTARGET]],
  capturable = false,	
  cloakCost             = 0,
  description        = [[Weapon]],
  defaultmissiontype    = [[Standby]],
  explodeAs          = [[NullDeath]],
  footprintX         = 1,
  footprintZ         = 1,
  hidedamage		 = 1,
  mass				 = 20,
  maxDamage          = 8000,
  maxSlope           = 255,
  name               = [[Rifle]],
  objectName         = [[wrifle.s3o]],
  pushResistant      = true,
  radarDistance      = 0,
  script             = [[weapon.lua]],
  selfDestructAs     = [[NullDeath]],
  selfDestructCountdown = 0,
  showNanoFrame      = false,
  sightDistance      = 0,
  TurnRate 			 = 0,
  unitname           = [[wrifle]],
  yardMap            = [[c]],

}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
