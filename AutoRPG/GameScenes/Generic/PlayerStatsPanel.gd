extends Control

func _ready():
	updatePanel()

func updatePanel():
	for stat in PlayerData.stats:
		var statLabel = get_node("Panel/" + stat)
		var text = GameData.icon[stat] + "\n" + str(PlayerData[stat])
		
		statLabel.bbcode_text = GameData.centerRichText(text)
