extends Node

const stats_icon = {
	"HP":"✃",
	"AP":"✄",
	"ATK":"✇",
	"MAG":"✌",
	"WALLET":"✉",
}

const icon = {
	"HP":"[color=red]" + stats_icon.HP + "[/color]",
	"AP":"[color=lime]" + stats_icon.AP + "[/color]",
	"ATK":"[color=silver]" + stats_icon.ATK + "[/color]",
	"MAG":"[color=aqua]" + stats_icon.MAG + "[/color]",
	"WALLET":"[color=yellow]" + stats_icon.WALLET + "[/color]",
	"GOLD":"✁",
	"LOCK":"✈",
	"SKULL":"✆",
	"FINAL":"✍",
	"PLAY":"✂",
	"LIST":"✎",
}

const menus = {
	"Stage":{
		"name":"STAGE SELECT",
		"scene":"res://GameScenes/StageSelect/StageSelect.tscn",
		"left":"Setup",
		"right":"Shop",
	},
	"Shop":{
		"name":"SHOP",
		"scene":"res://GameScenes/Shop/Shop.tscn",
		"left":"Stage",
		"right":"Setup",
	},
	"Setup":{
		"name":"SETUP",
		"scene":"res://GameScenes/Setup/Setup.tscn",
		"left":"Shop",
		"right":"Stage",
	},
}

var current_stage = "11"
var current_shop_type = "Stats"
var current_setup_type = "Skills"

func centerRichText(text):
	return "[center]" + text + "[/center]"
