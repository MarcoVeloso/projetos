extends Control

onready var title = $Panel/Title
onready var req = $Panel/Req
onready var desc = $Panel/Description
onready var buttonText = $Panel/Button/Text


func _ready():
	var stat = self.name
	
	drawStats(stat, ShopData.stats[stat])


func drawStats(stat, shop_data):
	title.bbcode_text = GameData.icon[stat] + "+" + str(shop_data.increment)
	desc.bbcode_text = shop_data.desc
	buttonText.text = "$\n" + str(shop_data.cost)
