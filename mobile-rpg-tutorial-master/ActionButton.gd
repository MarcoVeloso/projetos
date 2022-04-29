extends Button

const BattleUnits = preload("res://BattleUnits.tres")
const Attack = preload("res://Attacks.tscn")

func execute_skill(skill_name):
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	
	if enemy != null and playerStats != null:
		var skill = Attack.instance().init(skill_name)
		get_tree().current_scene.add_child(skill)
		skill.global_position = enemy.global_position
		
		enemy.take_damage(2)
		playerStats.mp += 2
		playerStats.ap -= 1
	
