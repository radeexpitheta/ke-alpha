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
  bmcode              = [[1]],
  canAttack          = true,
	capturable  = false,	
  	cancapture = true,
	CaptureSpeed = 100,
	canRepair = false,
	canRestore = false,
	canReclaim = false,
	canAssist = false,
  canMove                = true,
  canPatrol           = true,
  canstop             = [[1]],
  CantBeTransported = true,
  category           = "TARGET",
  capturable = false,	
  --cloakCost             = 0,
  	collisionvolumetype  = "box",
	collisionvolumescales = "0.4 0.6 0.5",
	collisionvolumeoffsets = "0 0.25 0",
   customParams = {
		--needed_cover=1,
		},	
  description        = "Weapon",
  defaultmissiontype    = "Standby",
  explodeAs          = "NullDeath",
  footprintX         = 1,
  footprintZ         = 1,
  hidedamage		 = 1,
  idleAutoHeal       = 0.5,
  idleTime           = 300,
  levelGround        = false,
  maneuverleashlength = [[640]],
  mass				 = 200,
  maxDamage          = 1000,
  maxSlope            = 18,
  SlopeMod 			  = 0.6, 
  maxVelocity        = 2.5,
  maxWaterDepth       = 22,
  minCloakDistance    = 400,
  movementClass      = "FOOT",
  name               = "Marine", 
  noChaseCategory    = "VEHICLE NOTARGET AIR", 
  name               = "Soldier",
  objectName         = "inf.s3o",
  pushResistant         = false,
  radarDistance      = 0,
  script             = "soldier.lua",
  seismicSignature    = 4,
  selfDestructAs     = "NullDeath",
  selfDestructCountdown = 0,
  sfxtypes           = {
    explosiongenerators = {
      "custom:MUZZLE",
      --"custom:FF_WINGTIPS",
							},
						},
  side                = [[Assault]],
  showNanoFrame      = false,
  showNanoSpray      = false,
  showPlayerName     = true,
  sightDistance      = 800,
  smoothAnim         = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  --TRANSPORT--
	  isTransport = true,
	  ReleaseHeld = true,		--transported units survive if transporter dies
	  TransportCapacity = 2,    --The number of units the transport can carry
	  transportSize = 500,
	  TransportMass = 101,
	  transportUnloadMethod = 2,
  turnInPlace	    = 1,
  turnRate           = 1500,
  transportByEnemy   = false,
  unitname           = "inf",
  upright            = true,
  workerTime         = 10,
  
  
weapons = {
		[1]  = {
		  def                = "target",
		  badtargetcategory  = "VEHICLE", 
		  onlyTargetCategory = "TARGET",
		  mainDir            = "0 0 1", 
		  maxAngleDif        = 120,
		},
	},

	
	--------------------------------------------------------------------------------

weaponDefs = {
  
		target = {
				  name                    = [[Target Aimer]],
				  intensity				  = 0,
				  avoidFeature            = true,
				  canAttackGround		  = false,
				  collideFriendly         = false,
				  craterBoost             = 0,
				  craterMult              = 0,
				  endsmoke                = [[0]],
				  noSelfDamage            = true,
				  range                   = 2000,
				  reloadtime              = 1,
				  renderType              = 0,
				  startsmoke              = [[0]],
				  tolerance               = 100,
				  turret                  = true,
				  weaponTimer             = 1,
				  weapontype			  = "LaserCannon",
				  weaponVelocity          = 9000,
						damage = {
						default = 0,
						nodamage = 0.1,
								},
				},
	},



	
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
