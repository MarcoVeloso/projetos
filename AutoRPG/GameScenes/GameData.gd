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
		"scene":"res://GameScenes/StageSelect/StageSelect.tscn",
		"left":"Setup",
		"right":"Shop",
	},
	"Shop":{
		"scene":"res://GameScenes/Shop/Shop.tscn",
		"left":"Stages",
		"right":"Setup",
	},
	"Setup":{
		"scene":"res://GameScenes/Shop/Shop.tscn",
		"left":"Shop",
		"right":"Stages",
	},
}
