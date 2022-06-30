extends Node

onready var skills_panel = $UI/Skills
onready var skill_type = $UI/SkillsBackPanel/Title


func _ready():
	var skills = ShopData[skill_type.text.to_lower()]
	var max_index = skills.size() - 1
	
	for skill in skills_panel.get_children():
		var index = int(skill.name)

		if index <= max_index:
			skill.drawSkill(skills[index])
		else:
			skill.visible = false
