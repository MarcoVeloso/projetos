extends Button

const BattleUnits = preload("res://Scenes/Battle/BattleUnits.tres")
const Skills = preload("res://Objects/Skills/Skills.tscn")

var skills_data = {
	"SLASH": {
		"damage":1,
		"ap":1,
		"description":"Slash - 1AP\nBasic slash attack"
	},
	"CROSS": {
		"damage":2,
		"ap":3,
		"description":"Cross Slash - 3AP\nCross slash attack"
	},
	"TRIPLE": {
		"damage":3,
		"ap":5,
		"description":"Triple Slash - 5AP\nTriple slash attack"
	},
	"COMBO": {
		"damage":10,
		"ap":10,
		"description":"Combo Slash - 10AP\nPowerful combo! Hits very very hard!"
	},
	
}

func execute_skill(skill_name):
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	var textbox = get_tree().current_scene.find_node("Textbox")		
	
	if enemy != null and playerStats != null:
		var skill = Skills.instance().init(skill_name)
		var skill_data = skills_data[skill_name]
		
		get_tree().current_scene.add_child(skill)
		skill.global_position = enemy.global_position
		
		enemy.take_damage(skill_data["damage"])
		playerStats.ap -= skill_data["ap"]
		
		textbox.text = skill_data["description"]
