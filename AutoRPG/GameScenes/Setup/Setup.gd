extends Node

onready var passive_skillpanel = $UI/PassivePanel/Passive
onready var active_skillpanel = $UI/ActivesPanel/Skill
onready var skill_buttons = $UI/ActivesPanel/SkillButtons

var skills_list = []


func _ready():
	loadPassives()
	loadSkills()
	active_skillpanel.descriptionOnly()


func loadPassives():
	var skills = PlayerData.shop_data["passives"]
	var current_skill = PlayerData.passive_skill
	
	passive_skillpanel.drawSkill(current_skill, skills[current_skill])
	
	for key in skills.keys():
		if !skills[key].costs:
			passive_skillpanel.loadItems([key])

func loadSkills():
	var skills = PlayerData.shop_data["skills"]
	
	for key in skills.keys():
		if !skills[key].costs:
			skills_list.append(key)
	
	skills_list.erase("SLASH")
	
	var first_skill = PlayerData.selected_skills[1]
	
	active_skillpanel.loadItems(skills_list)
	active_skillpanel.drawSkill(first_skill, skills[first_skill])
	
	for button in skill_buttons.get_children():
		var index = int(button.name)
		var skillname = PlayerData.selected_skills[index]

		if index == 0:
			continue

		if skillname:
			button.text = skillname
			button.disabled = false
			button.loadItems(skills_list)
