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
	collisionvolumescales = "1 1 1",
	collisionvolumeoffsets = "0 0 0",
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
	  TransportCapacity = 1,    --The number of units the transport can carry
	  transportSize = 500,
	  TransportMass = 100,
	  transportUnloadMethod = 2,
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

	
	--------------------------------------------------------------------------------

weaponDefs          = {
  
Gun = {
      name                    = [[Rifle]],
      areaOfEffect            = 8,
      avoidFeature            = false,
      canAttackGround		  = false,
      collideFriendly         = false,
      craterBoost             = 0,
      craterMult              = 0,

      damage = {
			default = 5,
			base = 0,
			veh = 0;
				},

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
      movingAccuracy     = 888,
      noSelfDamage            = true,
       duration                = 0.01,
      range                   = 600,
      reloadtime              = 2,
      renderType              = 0,
      rgbColor                = [[1 0.7 0.2]],
      --soundHit                = [[Rifle]],
	   coreThickness      = 0.15,
      soundStart              = [[Rifle]],
	  soundstartvolume		  = 0.5,
	  soundTrigger			  = true,
      sprayAngle              = 300,
      startsmoke              = [[0]],
	  thickness				  = 0.8,
      tolerance               = 600,
      turret                  = true,
      weaponTimer             = 1,
      weapontype			  = "LaserCannon",
      weaponVelocity          = 900,
    },

Grenade = {
      name                    = [[Grenades]],
      areaOfEffect            = 25,
	  gravityAffected = true,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 200,
        veh  = 100,
        base  = 0,
		inf  = 150,
      },

	  edgeeffectiveness		  = 1,
      explosionGenerator      = [[custom:SMALLMISSILE_EXPLOSION]], -- was FLASH2 
      fireStarter             = 70,
      groundbounce            = true,
		bounceslip			     = 1,
		bouncerebound		     = 0.5,
		numbounce			     = 2,
		holdtime				 = 2,	
	    minbarrelangle			 =-45,
		myGravity				 = 0.1,
      impulseBoost            = 0,
      impulseFactor           = 0,
      InterceptedByShieldType = 1,

      metalpershot            = 0,
      model                   = [[blunade.s3o]],
      noSelfDamage            = true,
      range                   = 200,
      reloadtime              = 3,
      renderType              = 6, --was 1
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
     -- soundHit                = [[grenade]],
     -- soundStart              = [[throw]],
      startsmoke              = [[1]],
	  sprayAngle              = 100,
      tolerance               = 10000,

      turret                  = true,
      weaponAcceleration      = 80,
      weaponTimer             = 10,
      --weaponType              = [[MissileLauncher]],
      weaponVelocity          = 80,
},


RecGun = {
	 name                    = [[Rifle]],
      areaOfEffect            = 8,
      avoidFeature            = false,
      burst                   = 3,
      burstrate               = 0.1,
	  canAttackGround		  = false,
      collideFriendly         = false,
      craterBoost             = 0,
      craterMult              = 0,

      damage = {
			default = 5,
			base = 0,
			veh = 0;
				},

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
      movingAccuracy     = 888,
      noSelfDamage            = true,
       duration                = 0.01,
      range                   = 600,
      reloadtime              = 2,
      renderType              = 0,
      rgbColor                = [[1 0.7 0.2]],
      --soundHit                = [[Rifle]],
	   coreThickness      = 0.15,
      soundStart              = [[Rifle]],
	  soundstartvolume		  = 0.5,
	  soundTrigger			  = true,
      sprayAngle              = 300,
      startsmoke              = [[0]],
	  thickness				  = 0.8,
      tolerance               = 600,
      turret                  = true,
      weaponTimer             = 1,
      weapontype			  = "LaserCannon",
      weaponVelocity          = 900,
},


Burner = {
	areaOfEffect       = 8,
    avoidFriendly      = 0,
    collideFriendly    = 0,
    craterBoost        = 1,
    craterMult         = 2,
    endsmoke           = "0",
    explosionGenerator = "custom:NONE",
    impactonly         = true,
    impulseBoost       = 0,
    impulseFactor      = 0.4,
    interceptedByShieldType = 1,
    lineOfSight        = false,
    name               = "Melee",
    noSelfDamage       = true,
    range              = 30,
    reloadtime         = 1.6,
    size               = 0,
    startsmoke         = 0,
    targetBorder       = 1,
    tolerance          = 5000,
    turret             = true,
    waterWeapon        = true,
    weaponTimer        = 0.1,
    weaponType         = "Cannon",
    weaponVelocity     = 500,
		damage = {
			default            = 5,
			},
	},

  },


	
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
