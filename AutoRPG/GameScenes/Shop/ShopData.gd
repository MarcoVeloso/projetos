extends Node

var data = {
	"HP":{
		"title":"HP+",
		"desc":"Increase Health Points",
		"increment":10,
		"cost":50,
	},
	"AP":{
		"title":"AP+",
		"desc":"Increase maximum Action Points",
		"increment":5,
		"cost":50,
	},
	"ATK":{
		"title":"ATK+",
		"desc":"Increase Attack Power",
		"increment":1,
		"cost":50,
	},
	"MAG":{
		"title":"MAG+",
		"desc":"Increase Magic Power",
		"increment":1,
		"cost":50,
	},
	"WALLET":{
		"title":"WALLET+",
		"desc":"Increase maximum $ stored",
		"increment":400,
		"cost":100,
	},
}


func _ready():
	var stats = ["HP", "AP", "ATK", "MAG", "WALLET"]
	
	for skill in data:
		var title = data[skill].title
		var desc = data[skill].desc
		
		for stat in stats:
			if stat in title:
				data[skill].title = title.replace(stat, GameData.icon[stat])
				
			if stat in desc:
				data[skill].desc = desc.replace(stat, GameData.icon[stat])



