extends Node

var skills = {
	"SLASH": {
		"target":"other",
		"type":"attack",
		"effect":1,
		"ap":0,
		"title":"Slash",
		"desc":"Deal %sxATK damage",
	},
	"SWIFT": {
		"target":"other",
		"type":"APgain",
		"effect":1,
		"ap":0,
		"title":"Swift Attack",
		"desc":"Deal %s damage and grant 1 AP to user",
	},
	"DEFEND": {
		"target":"self",
		"type":"shield",
		"effect":2,
		"ap":1,
		"title":"Defend",
		"desc":"Block %s damage next turn using a shield",
	},
	"HEAL": {
		"target":"self",
		"type":"heal",
		"effect":2,
		"ap":5,
		"title":"Heal",
		"desc":"Restore %sxMAG HP",
	},
	"CROSS": {
		"target":"other",
		"type":"attack",
		"effect":2,
		"ap":3,
		"title":"Cross Slash",
		"desc":"Deal %sxATK damage",
	},
	"CRESCENT": {
		"target":"other",
		"type":"attack",
		"effect":3,
		"ap":5,
		"title":"Crescent Slash",
		"desc":"Deal %sxATK damage",
	},
	"EXPLOSION": {
		"target":"other",
		"type":"magic",
		"effect":5,
		"ap":10,
		"title":"Explosion",
		"desc":"Deal %sxMAG damage",
	},
	"FIREBALLS": {
		"target":"other",
		"type":"magic",
		"effect":7,
		"ap":12,
		"title":"Fireballs",
		"desc":"Deal %sxMAG damage",
	},
	"ULTIMA": {
		"target":"other",
		"type":"magic",
		"effect":99,
		"ap":20,
		"title":"Ultima Explosion",
		"desc":"Deal %sxMAG damage",
	},
}

var passives = {
	"ATTACK_FIRST": {
		"title":"Attack First",
		"desc":"Deal the first attack on battles",
	},
	"ATTACK_BOOST": {
		"title":"Attack Boost",
		"desc":"Increase ATK by 25%",
	},
	"MAGIC_BOOST": {
		"title":"Magic Boost",
		"desc":"Increase MAG by 25%",
	},
	"AP_GAIN_BOOST": {
		"title":"AP Gain Boost",
		"desc":"Gain 2 AP per turn",
	},
}

var attributes = {
	"HP": {
		"title":"HP↑",
		"desc":"Increase Health Points",
		"values":[10,20,30,40,50],
		"costs":[0,50,200,500,1200],
	},
	"AP": {
		"title":"AP↑",
		"desc":"Increase max Action Points",
		"values":[5,10,20,30,40],
		"costs":[0,50,200,500,1200],
	},
	"ATK": {
		"title":"ATK↑",
		"desc":"Increase Attack Power",
		"values":[1,2,3,4,5],
		"costs":[0,50,200,500,1200],
	},
	"MAG": {
		"title":"MAG↑",
		"desc":"Increase Magic Power",
		"values":[1,2,3,4,5],
		"costs":[0,50,200,500,1200],
	},
	"WALLET": {
		"title":"WALLET↑",
		"desc":"Increase max $ carried",
		"values":[100, 200, 500, 1000, 2000, 5000, 10000],
		"costs":[0, 100, 200, 500, 1000, 2000, 5000],
	},
}


func _ready():
	skillsDescription()
	replaceStats(passives)
	replaceStats(attributes)


func skillsDescription():
	for skill in skills:
		skills[skill].title += " - %s AP" % skills[skill].ap
		skills[skill].desc = skills[skill].desc % skills[skill].effect
		
	replaceStats(skills)


func replaceStats(data):
	for skill in data:
		var title = data[skill].title
		var desc = data[skill].desc
		
		for stat in PlayerData.stats:
			if stat in title:
				data[skill].title = title.replace(stat, GameData.icon[stat])
				
			if stat in desc:
				data[skill].desc = desc.replace(stat, GameData.icon[stat])
