extends Control

onready var title = $Panel/Title
onready var req = $Panel/Req
onready var desc = $Panel/Description
onready var buttonText = $Panel/Button/Text

var stats = {
	"HP":"Increase Health Points",
	"AP":"Increase Action Points",
	"ATK":"Increase Attack Power",
	"MAG":"Increase Magic Power",
	"WALLET":"Increase maximum $",
}

func _ready():
	drawStats(self.name, 20, 9758)


func drawStats(stat, increment, cost):
	title.bbcode_text = GameData.icon[stat] + "+" + str(increment)
	desc.bbcode_text = stats[stat]
	buttonText.text = "$\n" + str(cost)
