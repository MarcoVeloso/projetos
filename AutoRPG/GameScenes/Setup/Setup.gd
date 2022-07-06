extends Node

onready var skills_panel = $UI/Skills


func _ready():
	loadSkills("Skills")


func loadSkills(type):
	var skills = PlayerData.shop_data[type.to_lower()]
	var skills_keys = skills.keys()

	for key in skills.keys():
		if skills[key].costs:
			skills_keys.remove(key)

	for skill in skills_panel.get_children():
		if skills_keys.empty():
			skill.visible = false
		else:
			var skillname = skills_keys.pop_front()

			skill.visible = true
			skill.drawSkill(skillname, skills[skillname])


func _on_Skills_pressed():
	loadSkills("Skills")


func _on_Passives_pressed():
	loadSkills("Passives")
