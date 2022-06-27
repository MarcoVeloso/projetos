extends Button

const BattleUnits = preload("res://GameScenes/Battle/BattleUnits.tres")

func _on_toggled(selected):
	if (selected):
		BattleUnits.Player.active_skill = text
		
		var title = get_tree().current_scene.find_node("Title")
		var desc = get_tree().current_scene.find_node("Description")
		
		title.bbcode_text = SkillsData.description[text]["title"]
		desc.bbcode_text = SkillsData.description[text]["desc"]
