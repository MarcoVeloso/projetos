extends Node

const icon = {
	"HP":"✃",
	"AP":"✄",
	"ATK":"✇",
	"MAG":"✌",
	"WALLET":"✉",
	"GOLD":"✁",
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
