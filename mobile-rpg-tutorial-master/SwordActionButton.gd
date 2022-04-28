extends "res://ActionButton.gd"

const Attack = preload("res://Attacks.tscn")

func _on_pressed():
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	
	if enemy != null and playerStats != null:
		var slash = Attack.instance().init("slash")
		get_tree().current_scene.add_child(slash)
		slash.global_position = enemy.global_position
		
		enemy.take_damage(2)
		playerStats.mp += 2
		playerStats.ap -= 1

	
