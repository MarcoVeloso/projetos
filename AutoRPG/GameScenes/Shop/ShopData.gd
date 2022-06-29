extends Node

var data = {
	"HP":{
		"type":"stat",
		"title":"HP↑",
		"desc":"Increase Health Points",
		"values":[10,20,30,40,50],
		"costs":[0,50,200,500,1200],
	},
	"AP":{
		"type":"stat",
		"title":"AP↑",
		"desc":"Increase max Action Points",
		"values":[5,10,20,30,40],
		"costs":[0,50,200,500,1200],
	},
	"ATK":{
		"type":"stat",
		"title":"ATK↑",
		"desc":"Increase Attack Power",
		"values":[1,2,3,4,5],
		"costs":[0,50,200,500,1200],
	},
	"MAG":{
		"type":"stat",
		"title":"MAG↑",
		"desc":"Increase Magic Power",
		"values":[1,2,3,4,5],
		"costs":[0,50,200,500,1200],
	},
	"WALLET":{
		"type":"stat",
		"title":"WALLET↑",
		"desc":"Increase max $ carried",
		"values":[100, 200, 500, 1000, 2000, 5000, 10000],
		"costs":[0, 100, 200, 500, 1000, 2000, 5000],
	},
}


func _ready():
	for skill in data:
		var title = data[skill].title
		var desc = data[skill].desc
		
		for stat in PlayerData.stats:
			if stat in title:
				data[skill].title = title.replace(stat, GameData.icon[stat])
				
			if stat in desc:
				data[skill].desc = desc.replace(stat, GameData.icon[stat])
