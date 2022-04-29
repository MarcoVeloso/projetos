extends Button

const BattleUnits = preload("res://BattleUnits.tres")
const Skills = preload("res://Skills.tscn")

var skill_data = {
	"SLASH": {
		"damage":1,
		"description":"Slash (1) \nBasic slash attack"
	},
	"CROSS": {
		"damage":2,
		"description":"Cross Slash (2) \nCross slash attack"
	},
	"TRIPLE": {
		"damage":3,
		"description":"Triple Slash (3) \nTriple slash attack"
	},
	"COMBO": {
		"damage":10,
		"description":"Combo Slash (99) \nPowerful combo! Hits very very hard!"
	},
	
}

func execute_skill(skill_name):
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	var textbox = get_tree().current_scene.find_node("Textbox")		
	
	if enemy != null and playerStats != null:
		var skill = Skills.instance().init(skill_name)
		get_tree().current_scene.add_child(skill)
		skill.global_position = enemy.global_position
		
		enemy.take_damage(skill_data[skill_name]["damage"])
		playerStats.mp += 2
		playerStats.ap -= 1
		
		textbox.text = skill_data[skill_name]["description"]
