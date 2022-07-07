extends Node

onready var passive_skillpanel = $UI/PassivePanel/Passive


func _ready():
	loadPassives()


func loadPassives():
	var skills = PlayerData.shop_data["passives"]
	var current_skill = PlayerData.passive_skill
	
	passive_skillpanel.drawSkill(current_skill, skills[current_skill])
	
	for key in skills.keys():
		if !skills[key].costs:
			passive_skillpanel.loadItem(key)
