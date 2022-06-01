extends Node

var data = {
	"SLASH": {
		"type":"damage",
		"subtype":"attack",
		"effect":1,
		"ap":0,
		"desc_name":"Slash",
		"desc_effect":"Deals %sx ATK Damage",
		"desc_text":"Basic slash attack",
	},
	"DEFEND": {
		"type":"positive",
		"subtype":"shield",
		"effect":1,
		"ap":1,
		"desc_name":"Defend",
		"desc_effect":"Blocks %s Damage next turn",
		"desc_text":"Rise a shield",
	},
	"HEAL": {
		"type":"positive",
		"subtype":"heal",
		"effect":2,
		"ap":5,
		"desc_name":"Heal",
		"desc_effect":"Restore %sx MAG HP",
		"desc_text":"Heal a portion of HP",
	},
	"CROSS": {
		"type":"damage",
		"subtype":"attack",
		"effect":2,
		"ap":3,
		"desc_name":"Cross Slash",
		"desc_effect":"Deals %sx ATK Damage",
		"desc_text":"Cross slash attack",
	},
	"CRESCENT": {
		"type":"damage",
		"subtype":"attack",
		"effect":3,
		"ap":5,
		"desc_name":"Crescent Slash",
		"desc_effect":"Deals %sx ATK Damage",
		"desc_text":"Heavy curved slash attack",
	},
	"EXPLOSION": {
		"type":"damage",
		"subtype":"magic",
		"effect":5,
		"ap":10,
		"desc_name":"Explosion",
		"desc_effect":"Deals %sx MAG Damage",
		"desc_text":"Powerful magic explosion",
	},
	"FIREBALLS": {
		"type":"damage",
		"subtype":"magic",
		"effect":7,
		"ap":12,
		"desc_name":"Fireballs",
		"desc_effect":"Deals %sx MAG Damage",
		"desc_text":"Two nasty fireballs",
	},
	"ULTIMA": {
		"type":"damage",
		"subtype":"magic",
		"effect":10,
		"ap":20,
		"desc_name":"Ultima Explosion",
		"desc_effect":"Deals %sx MAG Damage",
		"desc_text":"Ultimate explosion magic",
	},
}

var description = {}

func _ready():
	for skill in data:
		var s = data[skill]
		
		var desc = "%s - %s AP\n" % [s["desc_name"], s["ap"]]
		desc += s["desc_effect"] % s["effect"]
		desc += "\n%s" % s["desc_text"]
		
		description[skill] = desc 
