-- UNITDEF -- inf --
--------------------------------------------------------------------------------

local unitName = "inf"

--------------------------------------------------------------------------------

local unitDef = {
  acceleration       = 1.2,
  activatewhenbuilt	 = false,
  brakeRate          = 1.2,
  buildCostMetal     = 1,
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
  canMove            = true,
  canstop            = 1,
  category           = "INF", 
  -- minCloakDistance    = 450,
  collisionVolumeOffsets = "0 1 0",
  collisionVolumeScales  = "5.5 5.5 5.5",
  collisionVolumeTest    = 1,
  collisionVolumeType    = "box",
  customParams        = {
		toggle1 = 2,
		toggle1a = "Switch Weapons",
		toggle1b = "Switch Weapons",
		toggle1tooltip = "Switch Weapons: Hot Key q",
		--inf = true,
			},
  --corpse              = "DEAD",
  damageModifier 	 = 0.5,
  description        = "Infantry",
  explodeAs          = "NullDeath",
  footprintX         = 1,
  footprintZ         = 1,
  hidedamage		 = 1,
  --iconType           = "inf",
  idleAutoHeal       = 0.5,
  idleTime           = 300,
  levelGround        = false,
  mass				 = 100,
  maxDamage          = 1000,
  maxthisunit        = 1,
  maxVelocity        = 2.5,  -- run 3, slow 1
  metalMake          = 0,
  metalStorage       = 0,
  movementClass      = "FOOT",
  name               = "Marine", 
  noChaseCategory    = "VEHICLE NOTARGET AIR", 
  objectName         = "inf.s3o",
  pushResistant         = false,
  reclaimable        = false,
  script                 = "inf.lua",
  seismicSignature   = 5,   
  selfDestructAs     = "NullDeath",
  selfDestructCountdown = 1,
  showNanoFrame      = false,
  showNanoSpray      = false,
  --showPlayerName     = true, 
  side = "Goodguys",
  sightDistance      = 800, --- 800 standard, 600 defensive
  smoothAnim         = true,
  transportsize		= 1,
	  transportcapacity	= 1,
	  transportmaxunits	= 1,
	  transportUnloadMethod = 2,
	  transportmass		= 80,
  turnInPlace	    = 1,  --need for strafing
  turnRate           = 1500,
  transportByEnemy   = false,
  unitname           = "inf",
  upright            = true,
  workerTime         = 10,
  sfxtypes = {
    explosiongenerators = {
	"custom:JumpTrail",
						},
			},
 

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



--------------------------------------------------------------------------------

--[=[local featureDefs = {
    DEAD  = {
      description      = "Wreckage inf",
      blocking         = true,
      category         = "corpses",
      damage           = 3000,
      energy           = 0,
	  smoketime		   = 0,
	  ---featureDead      = "HEAP",
      featurereclamate = "SMUDGE01",
      footprintX       = 1,
      footprintZ       = 2,
      height           = "20",
      hitdensity       = "100",
      metal            = 0,
      object           = "infead.s3o",
      reclaimable      = false,
      reclaimTime      = 0,
      world            = "All Worlds",
    },
	
  },  ]=]
}
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
