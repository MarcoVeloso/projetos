extends Node

onready var skills_panel = $UI/Skills
onready var skill_type = $UI/SkillsBackPanel/Title
onready var buttonLeft = $UI/ButtonLeft
onready var buttonRight = $UI/ButtonRight


func _ready():
	loadSkills()


func loadSkills():
	var type = skill_type.text.to_lower()
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

