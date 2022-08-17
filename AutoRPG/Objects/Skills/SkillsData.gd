extends Node

const skills = {
	"SLASH": {
		"title":"Slash",
		"desc":"Deal %sxATK damage",
		"target":"other",
		"type":"attack",
		"effect":1,
		"ap":0,
		"req":null,
		"values":null,
		"costs":null,
		"level":0,
	},
	"HEAL": {
		"title":"Heal",
		"desc":"Restore %sxMAG health",
		"target":"self",
		"type":"heal",
		"effect":2,
		"ap":5,
		"req":null,
		"values":null,
		"costs":null,
		"level":1,
	},
	"CRESCENT": {
		"title":"Crescent Slash",
		"desc":"Deal %sxATK damage",
		"target":"other",
		"type":"attack",
		"effect":1.5,
		"ap":3,
		"req":"2 ATK",
		"values":null,
		"costs":[40],
		"level":1,
	},
	"SWIFT": {
		"title":"Swift Attack",
		"desc":"Deal %sxATK damage and grant 1 AP to user",
		"target":"other",
		"type":"APgain",
		"effect":0.3,
		"ap":0,
		"req":"3 ATK",
		"values":null,
		"costs":[200],
		"level":1,
	},
	"CROSS": {
		"title":"Cross Slash",
		"desc":"Deal %sxATK damage",
		"target":"other",
		"type":"attack",
		"effect":2,
		"ap":5,
		"req":"4 ATK",
		"values":null,
		"costs":[450],
		"level":1,
	},
	"DEFEND": {
		"title":"Defend",
		"desc":"Block %s damage next turn using a shield",
		"target":"self",
		"type":"shield",
		"effect":5,
		"ap":1,
		"req":"5 ATK",
		"values":null,
		"costs":[600],
		"level":1,
	},
	"EXPLOSION": {
		"title":"Explosion",
		"desc":"Deal %sxMAG damage",
		"target":"other",
		"type":"magic",
		"effect":5,
		"ap":8,
		"req":"3 MAG",
		"values":null,
		"costs":[300],
		"level":1,
	},
	"FIREBALLS": {
		"title":"Fireballs",
		"desc":"Deal %sxMAG damage",
		"target":"other",
		"type":"magic",
		"effect":8,
		"ap":12,
		"req":"5 MAG",
		"values":null,
		"costs":[1700],
		"level":2,
	},
	"ULTIMA": {
		"title":"Ultima Explosion",
		"desc":"Deal %sxMAG damage",
		"target":"other",
		"type":"magic",
		"effect":15,
		"ap":15,
		"req":"7 MAG",
		"values":null,
		"costs":[3000],
		"level":2,
	},
}

const passives = {
	"Attack First": {
		"title":"Attack First",
		"desc":"Deal the first attack on battles",
		"req":null,
		"values":null,
		"costs":null,
		"level":1,
	},
	"Regeneration": {
		"title":"Regeneration",
		"desc":"Restore 20% health at start of battle",
		"req":"4 MAG",
		"values":null,
		"costs":[200],
		"level":1,
	},
	"Gold Boost": {
		"title":"Gold Boost",
		"desc":"Increase $ received by 20%",
		"req":null,
		"values":null,
		"costs":[250],
		"level":1,
	},
	"Attack Boost": {
		"title":"Attack Boost",
		"desc":"Increase ATK by 20%",
		"req":"5 ATK",
		"values":null,
		"costs":[300],
		"level":1,
	},
	"Magic Boost": {
		"title":"Magic Boost",
		"desc":"Increase MAG by 20%",
		"req":"5 MAG",
		"values":null,
		"costs":[350],
		"level":1,
	},
	"Action Gain Boost": {
		"title":"Action Gain Boost",
		"desc":"Gain 2 AP per turn",
		"req":"6 MAG",
		"values":null,
		"costs":[500],
		"level":1,
	},
}

const stats = {
	"HP": {
		"title":"HP↑",
		"desc":"Increase Health Points",
		"req":null,
		"values":[10,20,30,40,50],
		"costs":[0,50,200,500,1200],
	},
	"AP": {
		"title":"AP↑",
		"desc":"Increase max Action Points",
		"req":null,
		"values":[5,10,20,30,40],
		"costs":[0,50,200,500,1200],
	},
	"ATK": {
		"title":"ATK↑",
		"desc":"Increase Attack Power",
		"req":null,
		"values":[1,2,3,4,5,6,7,8,9],
		"costs":[0,35,200,500,1200,2000,3500,6000,9999],
	},
	"MAG": {
		"title":"MAG↑",
		"desc":"Increase Magic Power",
		"req":null,
		"values":[1,2,3,4,5,6,7,8,9],
		"costs":[0,35,200,500,1200,2000,3500,6000,9999],
	},
	"WALLET": {
		"title":"WALLET↑",
		"desc":"Increase max $ carried",
		"req":null,
		"values":[100,200,500,1000,2000,4500,7000,9999,99999],
		"costs":[0,100,200,500,1000,2000,4500,7000,9999],
	},
}

func _ready():
	skillsDescription()
	replaceStats(passives)
	replaceStats(stats)
	prepareShopData()


func skillsDescription():
	for skill in skills:
		skills[skill].title += " - %sAP" % skills[skill].ap
		skills[skill].desc = skills[skill].desc % skills[skill].effect

	replaceStats(skills)


func replaceStats(data):
	for skill in data:
		for stat in PlayerData.stats:
			if stat in data[skill].title:
				data[skill].title = data[skill].title.replace(stat, GameData.icon[stat])

			if stat in data[skill].desc:
				data[skill].desc = data[skill].desc.replace(stat, GameData.icon[stat])


func prepareShopData():
	PlayerData.shop_data["skills"] = skills
	PlayerData.shop_data["passives"] = passives
	PlayerData.shop_data["stats"] = stats
