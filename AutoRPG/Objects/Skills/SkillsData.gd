extends Node

var data = {
	"SLASH": {
		"target":"other",
		"type":"attack",
		"effect":1,
		"ap":0,
		"desc_name":"Slash",
		"desc_effect":"Deal %sx ATK Damage",
	},
	"SWIFT": {
		"target":"other",
		"type":"APgain",
		"effect":1,
		"ap":0,
		"desc_name":"Swift Attack",
		"desc_effect":"Deal %s Damage and grant 1 AP to user",
	},
	"DEFEND": {
		"target":"self",
		"type":"shield",
		"effect":1,
		"ap":1,
		"desc_name":"Defend",
		"desc_effect":"Blocks %s Damage next turn using a shield",
	},
	"HEAL": {
		"target":"self",
		"type":"heal",
		"effect":2,
		"ap":5,
		"desc_name":"Heal",
		"desc_effect":"Restore %sx MAG HP",
	},
	"CROSS": {
		"target":"other",
		"type":"attack",
		"effect":2,
		"ap":3,
		"desc_name":"Cross Slash",
		"desc_effect":"Deal %sx ATK Damage",
	},
	"CRESCENT": {
		"target":"other",
		"type":"attack",
		"effect":3,
		"ap":5,
		"desc_name":"Crescent Slash",
		"desc_effect":"Deal %sx ATK Damage",
	},
	"EXPLOSION": {
		"target":"other",
		"type":"magic",
		"effect":5,
		"ap":10,
		"desc_name":"Explosion",
		"desc_effect":"Deal %sx MAG Damage",
	},
	"FIREBALLS": {
		"target":"other",
		"type":"magic",
		"effect":7,
		"ap":12,
		"desc_name":"Fireballs",
		"desc_effect":"Deal %sx MAG Damage",
	},
	"ULTIMA": {
		"target":"other",
		"type":"magic",
		"effect":10,
		"ap":20,
		"desc_name":"Ultima Explosion",
		"desc_effect":"Deal %sx MAG Damage",
	},
}

var description = {}

func _ready():
	for skill in data:
		var s = data[skill]
		
		description[skill] = {
			"title":"%s - %s AP" % [s["desc_name"], s["ap"]],
			"desc":s["desc_effect"] % s["effect"]
		}
	
