extends Button

func _on_toggled(selected):
	print(self.name)
#	if (selected):
#		BattleUnits.Player.active_skill = text
#
#		var title = get_tree().current_scene.find_node("Title")
#		var desc = get_tree().current_scene.find_node("Description")
#
#		title.bbcode_text = SkillsData.skills[text].title
#		desc.bbcode_text = SkillsData.skills[text].desc
