extends Node

var attributes = [
	{
		"name":"HP",
		"title":"HP↑",
		"desc":"Increase Health Points",
		"values":[10,20,30,40,50],
		"costs":[0,50,200,500,1200],
	},
	{
		"name":"AP",
		"title":"AP↑",
		"desc":"Increase max Action Points",
		"values":[5,10,20,30,40],
		"costs":[0,50,200,500,1200],
	},
	{
		"name":"ATK",
		"title":"ATK↑",
		"desc":"Increase Attack Power",
		"values":[1,2,3,4,5],
		"costs":[0,50,200,500,1200],
	},
	{
		"name":"MAG",
		"title":"MAG↑",
		"desc":"Increase Magic Power",
		"values":[1,2,3,4,5],
		"costs":[0,50,200,500,1200],
	},
	{
		"name":"WALLET",
		"title":"WALLET↑",
		"desc":"Increase max $ carried",
		"values":[100, 200, 500, 1000, 2000, 5000, 10000],
		"costs":[0, 100, 200, 500, 1000, 2000, 5000],
	},
]


func _ready():
	replaceStats(attributes)


func replaceStats(data):
	for skill in data:
		var title = skill.title
		var desc = skill.desc
		
		for stat in PlayerData.stats:
			if stat in title:
				skill.title = title.replace(stat, GameData.icon[stat])
				
			if stat in desc:
				skill.desc = desc.replace(stat, GameData.icon[stat])
