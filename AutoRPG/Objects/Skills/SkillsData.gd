extends Node

var skills = {
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
	},
	"CROSS": {
		"title":"Cross Slash",
		"desc":"Deal %sxATK damage",
		"target":"other",
		"type":"attack",
		"effect":2,
		"ap":3,
		"req":"9ATK",
		"values":null,
		"costs":[35],
	},
	"SWIFT": {
		"title":"Swift Attack",
		"desc":"Deal %s damage and grant 1 AP to user",
		"target":"other",
		"type":"APgain",
		"effect":1,
		"ap":0,
		"req":"9ATK",
		"values":null,
		"costs":[200],
	},
	"DEFEND": {
		"title":"Defend",
		"desc":"Block %s damage next turn using a shield",
		"target":"self",
		"type":"shield",
		"effect":2,
		"ap":1,
		"req":"9ATK",
		"values":null,
		"costs":[400],
	},
	"CRESCENT": {
		"title":"Crescent Slash",
		"desc":"Deal %sxATK damage",
		"target":"other",
		"type":"attack",
		"effect":3,
		"ap":5,
		"req":"9ATK",
		"values":null,
		"costs":[800],
	},
	"EXPLOSION": {
		"title":"Explosion",
		"desc":"Deal %sxMAG damage",
		"target":"other",
		"type":"magic",
		"effect":5,
		"ap":10,
		"req":"5MAG",
		"values":null,
		"costs":[1000],
	},
	"FIREBALLS": {
		"title":"Fireballs",
		"desc":"Deal %sxMAG damage",
		"target":"other",
		"type":"magic",
		"effect":7,
		"ap":12,
		"req":"5MAG",
		"values":null,
		"costs":[2000],
	},
	"ULTIMA": {
		"title":"Ultima Explosion",
		"desc":"Deal %sxMAG damage",
		"target":"other",
		"type":"magic",
		"effect":99,
		"ap":20,
		"req":"5MAG",
		"values":null,
		"costs":[9000],
	},
}

var passives = {
	"ATTACK_FIRST": {
		"title":"Attack First",
		"desc":"Deal the first attack on battles",
		"req":null,
		"values":null,
		"costs":null
	},
	"REGENARATION": {
		"title":"Regeneration",
		"desc":"Restore 20% health at start of battle",
		"req":"5MAG",
		"values":null,
		"costs":[800],
	},
	"ATTACK_BOOST": {
		"title":"Attack Boost",
		"desc":"Increase ATK by 25%",
		"req":"9ATK",
		"values":null,
		"costs":[1000],
	},
	"MAGIC_BOOST": {
		"title":"Magic Boost",
		"desc":"Increase MAG by 25%",
		"req":"5MAG",
		"values":null,
		"costs":[1500],
	},
	"AP_GAIN_BOOST": {
		"title":"Action Gain Boost",
		"desc":"Gain 2 AP per turn",
		"req":"5MAG",
		"values":null,
		"costs":[2000],
	},
}

var attributes = {
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
		"values":[1,2,3,4,5],
		"costs":[0,50,200,500,1200],
	},
	"MAG": {
		"title":"MAG↑",
		"desc":"Increase Magic Power",
		"req":null,
		"values":[1,2,3,4,5],
		"costs":[0,50,200,500,1200],
	},
	"WALLET": {
		"title":"WALLET↑",
		"desc":"Increase max $ carried",
		"req":null,
		"values":[100, 200, 500, 1000, 2000, 5000, 10000],
		"costs":[0, 100, 200, 500, 1000, 2000, 5000],
	},
}

func _ready():
	skillsDescription()
	replaceStats(passives)
	replaceStats(attributes)
	prepareShopData()


func skillsDescription():
	for skill in skills:
		skills[skill].title += " - %sAP" % skills[skill].ap
		skills[skill].desc = skills[skill].desc % skills[skill].effect
		
	replaceStats(skills)


func replaceStats(data):
	for skill in data:
		var title = data[skill].title
		var desc = data[skill].desc
		var req = str(data[skill].req)
		
		for stat in PlayerData.stats:
			if stat in title:
				data[skill].title = title.replace(stat, GameData.icon[stat])
				
			if stat in desc:
				data[skill].desc = desc.replace(stat, GameData.icon[stat])
				
			if stat in req:
				data[skill].req = req.replace(stat, GameData.stats_icon[stat])


func prepareShopData():
	var types = ["skills", "passives", "attributes"]
	
	for type in types:
		var prepared_data = []
		
		for data in self[type]:
			var skill = self[type][data]

			if !skill.costs:
				continue

			prepared_data.append({
				"type": type,
				"name": data,
				"title": skill.title,
				"desc": skill.desc,
				"values": skill.values,
				"costs": skill.costs,
				"req": skill.req,
			})

		PlayerData.shop_data[type] = prepared_data
