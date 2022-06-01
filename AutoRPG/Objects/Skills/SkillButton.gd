extends Button

const BattleUnits = preload("res://GameScenes/Battle/BattleUnits.tres")

func _on_toggled(selected):
	if (selected):
		BattleUnits.PlayerStats.active_skill = text
		
		var textbox = get_tree().current_scene.find_node("Textbox")
		textbox.text = SkillsData.description[text]

