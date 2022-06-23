extends Node

var data = {
	"SLASH": {
		"target":"other",
		"type":"attack",
		"effect":1,
		"ap":0,
		"desc_name":"Slash",
		"desc_effect":"Deal %sxATK damage",
	},
	"SWIFT": {
		"target":"other",
		"type":"APgain",
		"effect":1,
		"ap":0,
		"desc_name":"Swift Attack",
		"desc_effect":"Deal %s damage and grant 1 AP to user",
	},
	"DEFEND": {
		"target":"self",
		"type":"shield",
		"effect":2,
		"ap":1,
		"desc_name":"Defend",
		"desc_effect":"Block %s damage next turn using a shield",
	},
	"HEAL": {
		"target":"self",
		"type":"heal",
		"effect":2,
		"ap":5,
		"desc_name":"Heal",
		"desc_effect":"Restore %sxMAG HP",
	},
	"CROSS": {
		"target":"other",
		"type":"attack",
		"effect":2,
		"ap":3,
		"desc_name":"Cross Slash",
		"desc_effect":"Deal %sxATK damage",
	},
	"CRESCENT": {
		"target":"other",
		"type":"attack",
		"effect":3,
		"ap":5,
		"desc_name":"Crescent Slash",
		"desc_effect":"Deal %sxATK damage",
	},
	"EXPLOSION": {
		"target":"other",
		"type":"magic",
		"effect":5,
		"ap":10,
		"desc_name":"Explosion",
		"desc_effect":"Deal %sxMAG damage",
	},
	"FIREBALLS": {
		"target":"other",
		"type":"magic",
		"effect":7,
		"ap":12,
		"desc_name":"Fireballs",
		"desc_effect":"Deal %sxMAG damage",
	},
	"ULTIMA": {
		"target":"other",
		"type":"magic",
		"effect":99,
		"ap":20,
		"desc_name":"Ultima Explosion",
		"desc_effect":"Deal %sxMAG damage",
	},
}

var description = {}

func _ready():
	for skill in data:
		var s = data[skill]
		var desc = s["desc_effect"] % s["effect"]
		
		if "MAG" in desc:
			desc = desc.replace("MAG",GameData.icon.MAG)
		elif "ATK" in desc:
			desc = desc.replace("ATK",GameData.icon.ATK)
		
		description[skill] = {
			"title": "%s - %s %s" % [s["desc_name"], s["ap"], GameData.icon.AP],
			"desc": desc
		}
	
