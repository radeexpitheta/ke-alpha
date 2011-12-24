local modRules = {
	flankingBonus = {
		defaultMode					=	3,
	},
	experience = {
		powerScale					=	0.1,
		healthScale					=	0.1,
		reloadScale					=	0.1,
		experienceMult			=	10,
	},
	sensors = {
		los = {
			losMipLevel				=	1,
			airMipLevel				=	0.5,
		},
	},
	nanospray = {
		allow_team_colours	=	false,
	},

	CONSTRUCTION = {
{
	constructionDecay = 1,
	constructionDecayTime = 0,
	constructionDecaySpeed = 0.001,
},
},
}

return modRules

