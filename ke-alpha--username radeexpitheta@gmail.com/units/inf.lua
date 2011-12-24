-- UNITDEF -- inf --
--------------------------------------------------------------------------------

local unitName = "inf"

--------------------------------------------------------------------------------

local unitDef = {
  acceleration       = 1.2,
  activatewhenbuilt	 = false,
  brakeRate          = 1.2,
  buildCostMetal     = 0,
  buildTime          = 100,
  buildDistance      = 800,
  canAttack          = true,
	capturable  = false,	
  	cancapture = true,
	CaptureSpeed = 100,
	canRepair = false,
	canRestore = false,
	canReclaim = false,
	canAssist = false,
 -- canMove                = true,
  CantBeTransported = true,
  category           = "NOTARGET",
  capturable = false,	
  cloakCost             = 0,
  description        = "Weapon",
  defaultmissiontype    = "Standby",
  explodeAs          = "NullDeath",
  footprintX         = 1,
  footprintZ         = 1,
  hidedamage		 = 1,
  idleAutoHeal       = 0.5,
  idleTime           = 300,
  levelGround        = false,
  mass				 = 200,
  maxDamage          = 1000,
  maxVelocity        = 2.5,
  movementClass      = "FOOT",
  name               = "Marine", 
  noChaseCategory    = "VEHICLE NOTARGET AIR", 
  name               = "Soldier",
  objectName         = "inf.s3o",
  pushResistant         = false,
  radarDistance      = 0,
  script             = "soldier.lua",
  selfDestructAs     = "NullDeath",
  selfDestructCountdown = 0,
  showNanoFrame      = false,
  showNanoSpray      = false,
  showPlayerName     = true,
  sightDistance      = 800,
    smoothAnim         = true,
  transportsize		= 1,
	  transportcapacity	= 1,
	  transportmaxunits	= 1,
	  transportUnloadMethod = 2,
	  transportmass		= 80,
  turnInPlace	    = 1,
  turnRate           = 1500,
  transportByEnemy   = false,
  unitname           = "inf",
  upright            = true,
  workerTime         = 10,
  
  
weapons = {
		[1]  = {
		  def                = "RecGun",
		  badtargetcategory  = "VEHICLE", 
		  onlyTargetCategory = "TARGET",
		  mainDir            = "0 0 1", 
		  maxAngleDif        = 120,
		},
		[2]  = {
		  def                = "Burner",
		  badtargetcategory  = "VEHICLE",
		  onlyTargetCategory = "TARGET",
		  mainDir            = "0 0 1", 
		  maxAngleDif        = 120,
		},
		[3]  = {
		  def                = "Gun",
		  badtargetcategory  = "VEHICLE",
		  onlyTargetCategory = "TARGET",
		  mainDir            = "0 0 1",
		  maxAngleDif        = 120,
		},
		[4]  = {
		  def                = "Grenade",
		  badtargetcategory  = "VEHICLE", 
		  onlyTargetCategory = "TARGET",
		  mainDir            = "0 0 1", 
		  maxAngleDif        = 120,
		},
	},

}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
