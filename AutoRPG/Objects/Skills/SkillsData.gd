extends Node

const data = {
	"SLASH": {
		"type":"damage",
		"effect":1,
		"ap":0,
		"description":"Slash - 0AP\nBasic slash attack"
	},
	"DEFEND": {
		"type":"shield",
		"effect":1,
		"ap":1,
		"description":"Defend - 1AP\nAbsorb 1 point of damage on next turn"
	},
	"HEAL": {
		"type":"heal",
		"effect":5,
		"ap":5,
		"description":"Heal - 2AP\nHeal a tiny portion of Hero HP"
	},
	"CROSS": {
		"type":"damage",
		"effect":2,
		"ap":3,
		"description":"Cross Slash - 3AP\nCross slash attack"
	},
	"CRESCENT": {
		"type":"damage",
		"effect":4,
		"ap":5,
		"description":"Crescent Slash - 5AP\nA powerful curved slash attack"
	},
	"EXPLOSION": {
		"type":"damage",
		"effect":7,
		"ap":10,
		"description":"Explosion - 8AP\nPowerful explosion"
	},
	"FIREBALLS": {
		"type":"damage",
		"effect":10,
		"ap":12,
		"description":"Fireballs - 10AP\nTwo nasty fireballs"
	},
	"ULTIMA": {
		"type":"damage",
		"effect":15,
		"ap":20,
		"description":"Ultima Explosion - 15AP\nUltimate explosion magic! Hits very very hard!"
	},
}
