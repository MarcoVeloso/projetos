extends Node

const icon = {
	"HP":"[color=red]✃[/color]",
	"AP":"[color=lime]✄[/color]",
	"ATK":"[color=silver]✇[/color]",
	"MAG":"[color=aqua]✌[/color]",
	"WALLET":"[color=yellow]✉[/color]",
	"GOLD":"[color=yellow]✁[/color]",
	"LOCK":"✈",
	"SKULL":"✆",
	"FINAL":"✍",
	"PLAY":"✂",
}

const menus = {
	"Stages":{
		"name":"STAGE SELECT",
		"scene":"res://GameScenes/StageSelect/StageSelect.tscn",
		"left":"Setup",
		"right":"Shop",
	},
	"Shop":{
		"name":"SHOP",
		"scene":"res://GameScenes/Shop/Shop.tscn",
		"left":"Stages",
		"right":"Setup",
	},
	"Setup":{
		"name":"SETUP SKILLS",
		"scene":"res://GameScenes/Setup/Setup.tscn",
		"left":"Shop",
		"right":"Stages",
	},
}

func centerRichText(text):
	return "[center]" + text + "[/center]"
