-- UNITDEF -- wcshot --
--------------------------------------------------------------------------------

local unitName = "wcshot"

--------------------------------------------------------------------------------

local unitDef = {
	unitname           = [[wcshot]],
	name               = [[Combat Shotgun]],
	description        = [[Weapon]],	
	--iconType		    = "weapon",
   -- acceleration        = 0,
  --bmcode              = [[1]],
  --brakeRate           = 0,
  buildCostMetal     = 0,
  canAttack          = true,
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
  objectName         = [[wcshot.s3o]],
  pushResistant      = true,
  radarDistance      = 0,
  script             = [[wrifle.lua]],
  selfDestructAs     = [[NullDeath]],
  selfDestructCountdown = 0,
  showNanoFrame      = false,
  sightDistance      = 0,
  smoothAnim          = true,
  steeringmode        = [[1]],
  TEDClass            = [[TANK]],
  TurnRate 			 = 1,

  weapons = {
		[1]  = {
		  def                = "SmallBullet",
		  badtargetcategory  = "VEHICLE", 
		  onlyTargetCategory = "MAKEME",
		  mainDir            = "0 0 1", 
		  maxAngleDif        = 120,
				},
	},
  
  -------------------------------
  
  
weaponDefs = {
  
SmallBullet = {
      name                    = [[Small Caliber]],
      areaOfEffect            = 4,
	  burst 				  = 6,
	  burstRate 			  = 0,
	  movingAccuracy    	  = 900,
	  range                   = 200,
      reloadtime              = 2,
	  sprayAngle              = 900,
	  weaponVelocity          = 900,
	      damage = 	{
			default = 12,
			base = 0,
			veh = 0;
					},
      avoidFeature            = false,
      canAttackGround		  = false,
      collideFriendly         = false,
      craterBoost             = 0,
      craterMult              = 0,
	  edgeEffectiveness       = 0.5,
      endsmoke                = [[0]],
      explosionGenerator      = [[custom:Bullet]],
      firestarter             = 70,
	  impactOnly 			= 1,
      impulseBoost            = 0,
      impulseFactor           = 0.2,
      InterceptedByShieldType = 2,
	  laserFlareSize     = 0.0001,
	  leadbonus				  = 5, --works?
      noSelfDamage            = true,
      duration                = 0.01,
      renderType              = 0,
      rgbColor                = [[1 0.7 0.2]],
      --soundHit                = [[Rifle]],
	  coreThickness      = 0.15,
      soundStart              = [[Rifle]],
	  soundstartvolume		  = 0.5,
	  soundTrigger			  = true,
      startsmoke              = [[0]],
	  thickness				  = 0.8,
      tolerance               = 600,
      turret                  = true,
      weaponTimer             = 1,
      weapontype			  = "LaserCannon", 
			},
  },
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
