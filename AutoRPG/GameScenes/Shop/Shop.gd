extends Node

onready var skills_panel = $UI/Skills
onready var skill_type = $UI/SkillsBackPanel/Title


func _ready():
	loadSkills("attributes")


func loadSkills(type):
	var skills = PlayerData.shop_data[type]
	var skills_keys = skills.keys()
	
	for key in skills.keys():
		if !skills[key].costs:
			skills_keys.remove(key)

	for skill in skills_panel.get_children():
		if skills_keys.empty():
			skill.visible = false
		else:
			var skillname = skills_keys.pop_front()

			skill.visible = true
			skill.drawSkill(skillname, skills[skillname])


func _on_Stats_pressed():
	loadSkills("attributes")


func _on_Skills_pressed():
	loadSkills("skills")


func _on_Passives_pressed():
	loadSkills("passives")
