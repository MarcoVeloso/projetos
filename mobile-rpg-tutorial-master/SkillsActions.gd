extends Button

const BattleUnits = preload("res://BattleUnits.tres")
const Skills = preload("res://Skills.tscn")

func execute_skill(skill_name):
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	
	if enemy != null and playerStats != null:
		var skill = Skills.instance().init(skill_name)
		get_tree().current_scene.add_child(skill)
		skill.global_position = enemy.global_position
		
		enemy.take_damage(2)
		playerStats.mp += 2
		playerStats.ap -= 1
	
func set_textbox(description):
	var textbox = get_tree().current_scene.find_node("Textbox")
	
	textbox.text = description
