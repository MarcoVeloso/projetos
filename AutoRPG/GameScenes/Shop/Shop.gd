extends Node

onready var skills_panel = $UI/Skills
onready var skill_type = $UI/SkillsBackPanel/Title
onready var buttonLeft = $UI/ButtonLeft
onready var buttonRight = $UI/ButtonRight

func _ready():
	loadSkills()
	
func loadSkills():
	var type = skill_type.text.to_lower()
	var skills = SkillsData.shop[type]
	var max_index = skills.size() - 1
	
	for skill in skills_panel.get_children():
		var index = int(skill.name)

		if index <= max_index:
			skill.visible = true
			skill.drawSkill(skills[index])
		else:
			skill.visible = false
	
	skills_panel.add_constant_override("separation", clamp((6 - max_index) * 2, 0, 7))


func _on_ButtonLeft_pressed():
	buttonTypes(buttonLeft.text)


func _on_ButtonRight_pressed():
	buttonTypes(buttonRight.text)
	
	
func buttonTypes(type_text):
	skill_type.text = type_text
	loadSkills()
	
	match type_text:
		"Attributes":
			buttonLeft.text = "Skills"
			buttonRight.text = "Passives"
		"Skills":
			buttonLeft.text = "Attributes"
			buttonRight.text = "Passives"
		"Passives":
			buttonLeft.text = "Skills"
			buttonRight.text = "Attributes"
	
