extends Node

onready var passive_skillpanel = $UI/PassivePanel/Passive
onready var active_skillpanel = $UI/ActivesPanel/Skill
onready var skill_buttons = $UI/ActivesPanel/SkillButtons

var passives = PlayerData.shop_data["passives"]
var skills = PlayerData.shop_data["skills"]


func _ready():
	loadPassives()
	loadSkills()
	active_skillpanel.descriptionOnly()


func loadPassives():
	updatePassiveDescription(PlayerData.passive_skill)

	for key in passives.keys():
		if !passives[key].costs:
			passive_skillpanel.loadItems([key])


func loadSkills():
	var skills_list = []

	updateSkillsScreen()
	updateSkillDescription("SLASH")

	for key in skills.keys():
		if !skills[key].costs:
			skills_list.append(key)

	skills_list.erase("SLASH")

	for button in skill_buttons.get_children():
		if button.name == "0":
			continue

		button.loadItems(skills_list)


func updatePassiveDescription(passive):
	passive_skillpanel.drawSkill("passive", passives[passive])


func updateSkillDescription(skill):
	active_skillpanel.drawSkill(skill, skills[skill])
	

func updateSkillsScreen():
	for button in skill_buttons.get_children():
		var index = int(button.name)
		var skillname = PlayerData.selected_skills[index]

		if index == 0:
			continue

		if skillname:
			button.text = skillname
			button.disabled = false
