extends Control

onready var title = $Panel/Title
onready var req = $Panel/Req
onready var desc = $Panel/Description

var stats = {
	"HP":"Increase Health Points",
	"AP":"Increase Action Points",
	"ATK":"Increase Attack Power",
	"MAG":"Increase Magic Power",
	"WALLET":"Increase maximum $",
}

func _ready():
	drawStats(self.name)


func drawStats(stat):
	title.bbcode_text = GameData.icon[stat] + "+"
	desc.bbcode_text = stats[stat]
