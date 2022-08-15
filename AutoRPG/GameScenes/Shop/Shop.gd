extends Node

onready var skills_panel = $UI/Skills
onready var stars = $UI/SkillsBackPanel/Stars


func _ready():
	var node = get_node("UI/SkillsBackPanel/" + GameData.current_shop_type)
	node.emit_signal("pressed")
	node.pressed = true


func loadSkills(type):
	var skills = PlayerData.shop_data[type]
	var skills_keys = skills.keys()
	
	for key in skills.keys():
		if !skills[key].costs:
			skills_keys.erase(key)

	for skill in skills_panel.get_children():
		if skills_keys.empty():
			skill.visible = false
		else:
			var skillname = skills_keys.pop_front()

			skill.visible = true
			skill.drawSkill(skillname, skills[skillname])


func _on_Stats_pressed():
	skillType("Stats")


func _on_Skills_pressed():
	skillType("Skills")
	stars.visible = true


func _on_Passives_pressed():
	skillType("Passives")


func skillType(type):
	GameData.current_shop_type = type
	loadSkills(type.to_lower())
	stars.visible = false
